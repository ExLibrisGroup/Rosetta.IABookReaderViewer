<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String numOfPages = request.getParameter("num_of_pages");
	String ext = request.getParameter("extension");
	String imageFile = request.getParameter("imageFile");
	int imageHeight = Integer.valueOf(request.getParameter("image_height"));
	int imageWidth = Integer.valueOf(request.getParameter("image_width"));
	boolean isMobile = Boolean.valueOf(request.getParameter("is_mobile"));
	String generalTitle = request.getParameter("ie_title") != null ? request.getParameter("ie_title") : "No Title";

	String markLanguage = "&language=";
	String markFileIndex = "&file_index=";
	String language = "";
	if(imageFile.indexOf(markLanguage) > 0 && imageFile.indexOf(markFileIndex) > 0){
		language = imageFile.substring(imageFile.indexOf(markLanguage) + markLanguage.length(), imageFile.indexOf(markFileIndex));
	}
%>

<head>
    <title>Book Reader Viewer</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Language" content="he"/>
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
var all_languages = ',heb,jrb,ara,arc,jpr,peo,per,he,jr,ar,jp,pe,';

var linkToFile = '<%=imageFile%>';
var num_of_pages = <%=numOfPages%>;
var general_title= "<%=generalTitle%>";
var pageW= <%=imageWidth%>;
var pageH= <%=imageHeight%>;
var language = '<%=language%>';

var title_zoom_in = 'הגדלה';
var title_zoom_out = 'הקטנה';
var title_onepg = 'תצוגת דף בודד';
var title_twopg = 'תצוגת ספר';
var title_thumb = 'תצוגת תמונות ממוזערות';
var title_book_left = 'דפדף שמאלה';
var title_book_right = 'דפדף ימינה';
var title_BRdn = 'הצג במסך מלא';
var title_play = 'הפעל';
var title_pause = 'עצור';
var title_fullscreen = 'הצג במסך מלא';
var extension = "<%=ext%>";
var ui_mode = "full";
var display_mode = 2;
var onepage_auto = "height";
var pageProgression = 'rl';

if(<%=isMobile%>){
	ui_mode = "embed";
	display_mode = 1;
	onepage_auto = "width";
}
if(!((language.replace(/\s/g,"") == "")||(all_languages.indexOf(','+language+',') >= 0)) ){
	pageProgression = '';
}
var fileArray = new Array();
</script>
<script type="text/javascript" src="BookReader/BookReaderInit.js"></script>

</body>
</html>
