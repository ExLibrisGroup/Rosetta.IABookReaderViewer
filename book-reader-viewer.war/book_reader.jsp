<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String numOfPages = request.getParameter("num_of_pages");
	String ext = request.getParameter("extension");
	String imageFile = request.getParameter("imageFile");
	int imageHeight = Integer.valueOf(request.getParameter("image_height"));
	int imageWidth = Integer.valueOf(request.getParameter("image_width"));
	boolean isMobile = Boolean.valueOf(request.getParameter("is_mobile"));
	String generalTitle = request.getParameter("ie_title") != null ? request.getParameter("ie_title") : "No Title";
%>

<head>
    <title>Book Reader Viewer</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Language" content="en"/>
    <link rel="stylesheet" type="text/css" href="BookReader/BookReader.css"/>

    <script type="text/javascript" src="BookReader/jquery-1.4.3.min.js"></script>
    <script type="text/javascript" src="BookReader/jquery-ui-1.8.5.custom.min.js"></script>
    <script type="text/javascript" src="BookReader/dragscrollable.js"></script>
    <script type="text/javascript" src="BookReader/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="BookReader/jquery.ui.ipad.js"></script>
    <script type="text/javascript" src="BookReader/jquery.bt.min.js"></script>

    <script type="text/javascript" src="BookReader/BookReader.js"></script>
</head>
<body class="viewerBody" style="background-color: ##939598;">
	<div id="BookReader" class="mainContainer viewerMainHolder">
    	Internet Archive BookReader <br/>

    	<noscript>
    	<p>
        	The BookReader requires JavaScript to be enabled. Please check that your browser supports JavaScript and that it is enabled in the browser settings.</a>.
    	</p>
    	</noscript>
	</div>
<script type="text/javascript">
var linkToFile = '<%=imageFile%>';
var num_of_pages = <%=numOfPages%>;
var general_title= "<%=generalTitle%>";
var pageW= <%=imageWidth%>;
var pageH= <%=imageHeight%>;

var title_zoom_in = '<fmt:message key="title_zoom_in"/>';
var title_zoom_out = '<fmt:message key="title_zoom_out"/>';
var title_onepg = '<fmt:message key="title_onepg"/>';
var title_twopg = '<fmt:message key="title_twopg"/>';
var title_thumb = '<fmt:message key="title_thumb"/>';
var title_book_left = '<fmt:message key="title_book_left"/>';
var title_book_right = '<fmt:message key="title_book_right"/>';
var title_BRdn = '<fmt:message key="title_BRdn"/>';
var title_play = '<fmt:message key="title_play"/>';
var title_pause = '<fmt:message key="title_pause"/>';
var title_fullscreen = '<fmt:message key="title_fullscreen"/>';
var extension = "<%=ext%>"
var ui_mode = "full";
var display_mode = 2;
var onepage_auto = "height";
if(<%=isMobile%>){
	ui_mode = "embed";
	display_mode = 1;
	onepage_auto = "width";
}
var fileArray = new Array();
</script>
<script type="text/javascript" src="BookReader/BookReaderInit.js"></script>

</body>
</html>
