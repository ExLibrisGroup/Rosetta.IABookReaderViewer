package bookreader.viewer;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.util.PropertyResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.namespace.QName;

import com.exlibris.dps.ws.delivery.DeliveryAccessWS;
import com.exlibris.dps.ws.delivery.DeliveryAccessWS_Service;
import com.exlibris.dps.ws.delivery.Exception_Exception;


public class BookReaderViewer extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final String VIEWER_PROPERTIES = "/conf/viewer.properties";
	private static final String WSDL_LOCATION = "wsdlLocation";

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String wsdlLocation = getWsdUrl();
		URL wsdlLocationUrl = new URL(wsdlLocation);
		DeliveryAccessWS deliveryAccessWS = new DeliveryAccessWS_Service(wsdlLocationUrl,new QName("http://dps.exlibris.com/", "DeliveryAccessWS")).getDeliveryAccessWSPort();

		String dvs = request.getParameter("dps_dvs");
		String repPid = request.getParameter("rep_pid");

		String redirect = "";
		try {
			String baseFileUrl = deliveryAccessWS.getBaseFileUrl(dvs);
			String imageFile = baseFileUrl + repPid + "&file_index=";

			redirect = "book_reader.jsp?imageFile=" + URLEncoder.encode(imageFile, "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
			redirect = "error.jsp";
		}
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(redirect);
		requestDispatcher.forward(request, response);
	}

	private String getWsdUrl() {
		PropertyResourceBundle resourceBundle = null;
		InputStream resourceAsStream = null;
		try {
			resourceAsStream = getServletContext().getResourceAsStream(VIEWER_PROPERTIES);
			resourceBundle = new PropertyResourceBundle(resourceAsStream);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				resourceAsStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		String wsdlLocation =  resourceBundle.getString(WSDL_LOCATION);
		return wsdlLocation;
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}