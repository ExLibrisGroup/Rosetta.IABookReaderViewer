package bookreader.viewer;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.namespace.QName;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;

import com.exlibris.dps.ws.delivery.DeliveryAccessWS;
import com.exlibris.dps.ws.delivery.DeliveryAccessWS_Service;

public class NliBookReaderViewer extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static Properties prop = null;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		if(prop == null){
			String fileName = config.getInitParameter("bookreaderPropertyFile");
			InputStream input = getServletContext().getResourceAsStream(fileName);
			prop = new Properties();
			try {
				prop.load(input);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String wsdlLocation = prop.getProperty("DeliveryAccessWSurl");
		URL wsdlLocationUrl = new URL(wsdlLocation);
		DeliveryAccessWS deliveryAccessWS = new DeliveryAccessWS_Service(wsdlLocationUrl,
				new QName("http://dps.exlibris.com/", "DeliveryAccessWS")).getDeliveryAccessWSPort();

		String dvs = request.getParameter("dps_dvs");
		String repPid = request.getParameter("rep_pid");
		String iePid = request.getParameter("ie_pid");

		String redirect = "";
		String language = "";
		Document doc = null;
		try {
			String xmlDocument = deliveryAccessWS.getMetadata(dvs, iePid, "descriptive", "dc");
			InputSource inputSource = new InputSource( new StringReader( xmlDocument ) );
			//File xmlFile = new File("C:\\dev\\workspace\\Rossetta-BookReader\\src\\bookreader\\viewer\\test.xml");
			DocumentBuilderFactory documentFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder documentBuilder = documentFactory.newDocumentBuilder();
			doc = documentBuilder.parse(inputSource);
			//doc.getDocumentElement().normalize();
//			System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if(doc != null){
				language = ((Element) doc.getElementsByTagName("dc:record").item(0))
					.getElementsByTagName("dc:language").item(0).getTextContent();
			}
		} catch (Exception e) {
		}
		try {
			String baseFileUrl = deliveryAccessWS.getBaseFileUrl(dvs);
			String imageFile = baseFileUrl + repPid + "&language="+language+"&file_index=";
			redirect = "book_reader.jsp?imageFile=" + URLEncoder.encode(imageFile, "UTF-8");
		} catch (Exception e) {
			//logger.error("Error In NliBookReaderViewer->DoGet 2", e);
			e.printStackTrace();
			redirect = "error.jsp";
		}
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(redirect);
		requestDispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}