//
// This file shows the BookReader initial configuration
//
// Copyright(c)2008-2009 Internet Archive. Software license AGPL version 3.

// Create the BookReader object
br = new BookReader();
br.mode = display_mode;

// Return the width of a given page.  Here we assume all images are 800 pixels wide
br.getPageWidth = function(index) {
	return pageW;
}

// Return the height of a given page.  Here we assume all images are 1200 pixels high
br.getPageHeight = function(index) {
	return pageH;
}

//using a different URL structure
br.getPageURI = function(index, reduce, rotate) {
	var url;
	if('undefined' != fileArray[index] && fileArray.length>0){
		url = linkToFile + fileArray[index];
	}else{
		url = linkToFile + index + "." + extension;
	}
	return url;
}

// Return which side, left or right, that a given page should be displayed on
br.getPageSide = function(index) {
    if (0 == (index & 0x1)) {
        return 'R';
    } else {
        return 'L';
    }
}

// This function returns the left and right indices for the user-visible
// spread that contains the given index.  The return values may be
// null if there is no facing page or the index is invalid.
br.getSpreadIndices = function(pindex) {
    var spreadIndices = [null, null];
    if ('rl' == this.pageProgression) {
        // Right to Left
        if (this.getPageSide(pindex) == 'R') {
            spreadIndices[1] = pindex;
            spreadIndices[0] = pindex + 1;
        } else {
            // Given index was LHS
            spreadIndices[0] = pindex;
            spreadIndices[1] = pindex - 1;
        }
    } else {
        // Left to right
        if (this.getPageSide(pindex) == 'L') {
            spreadIndices[0] = pindex;
            spreadIndices[1] = pindex + 1;
        } else {
            // Given index was RHS
            spreadIndices[1] = pindex;
            spreadIndices[0] = pindex - 1;
        }
    }

    return spreadIndices;
}

// For a given "accessible page index" return the page number in the book.
//
// For example, index 5 might correspond to "Page 1" if there is front matter such
// as a title page and table of contents.
br.getPageNum = function(index) {
    return index;
}

// Total number of leafs
br.numLeafs = num_of_pages;

// Book title and the URL used for the book title link
br.bookTitle = general_title;
br.bookUrl  = '';

// Override the path used to find UI images
br.imagesBaseURL = 'BookReader/images/';

br.getEmbedCode = function(frameWidth, frameHeight, viewParams) {
    return "Embed code not supported in bookreader demo.";
}

// Let's go!
br.init();

//read-aloud and search need backend compenents and are not supported in the demo
$('#BRtoolbar').find('.read').hide();
$('#BRtoolbar').find('.share').hide();
$('#BRtoolbar').find('.info').hide();
$('#BRtoolbar').find('.logo').hide();
$('#BRtoolbar').find('#BRreturn').hide();
$('#textSrch').hide();
$('#btnSrch').hide();

