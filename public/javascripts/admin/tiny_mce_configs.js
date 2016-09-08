// GLOBALS (MOSTLY USED IN THE POPUP WINDOWS)
var linkText = "";
var currentLink = "";
var bookmark;

// ADVANCED
tinyMCE.init({
  mode : "textareas",
  theme : "advanced",
  editor_selector : "advanced",
  extended_valid_elements : "iframe[src|width|height|name|align|allowfullscreen]",
  content_css:"/stylesheets/tnymc.css",
  theme_advanced_toolbar_location : "top",
  theme_advanced_buttons1 : "bold, italic, underline, separator, sub, sup, separator, justifyleft, justifycenter, justifyright, justifyfull, separator, bullist, numlist, separator, undo, redo",
  theme_advanced_buttons2 : "styleselect, formatselect, separator, picturemanager, documentmanager, linkmanager, unlink, hr ,separator, pasteword, separator, code",
  theme_advanced_buttons3 : "",
  plugins : 'paste',
  setup : function(ed) {
    ed.addButton('picturemanager', {
      title : 'Picture Manager',
      image : '/images/admin/picture_manager.gif',
      onclick : function() {
        pictureManager(ed);
      }
    });
    ed.addButton('documentmanager', {
      title : 'Document Manager',
      image : '/images/admin/document_manager.gif',
      onclick : function() {
        documentManager(ed);
      }
    });
    ed.addButton('linkmanager', {
      title : 'Link Mananger',
      image : '/images/admin/link_manager.gif',
      onclick : function() {
        linkManager(ed);
      }
    });
  }
});

// BASIC
tinyMCE.init({
  mode : "textareas",
  theme : "advanced",
  theme_advanced_toolbar_location : "top",
  editor_selector : "simple",
  theme_advanced_buttons1 : "bold, italic, underline, separator, justifyleft, justifycenter, justifyright, justifyfull, separator, bullist, numlist, separator, undo, redo, seperator, pasteword, seperator, code",
  theme_advanced_buttons2 : "",
  theme_advanced_buttons3 : "",
  forced_root_block : ""
});

// LINKER
tinyMCE.init({
  mode : "textareas",
  theme : "advanced",
  theme_advanced_toolbar_location : "top",
  editor_selector : "linker",
  extended_valid_elements : "iframe[src|width|height|name|align]",
  theme_advanced_buttons1 : "linkmanager, unlink, documentmanager, separator, pasteword, bold, italic, underline, separator, undo, redo, code",
  theme_advanced_buttons2 : "",
  theme_advanced_buttons3 : "",
  setup : function(ed) {
    ed.addButton('linkmanager', {
      title : 'Link Mananger',
      image : '/images/admin/link_manager.gif',
      onclick : function() {
        linkManager(ed);
      }
    });
    ed.addButton('documentmanager', {
      title : 'Document Manager',
      image : '/images/admin/document_manager.gif',
      onclick : function() {
        documentManager(ed);
      }
    });
  }
});

function pictureManager(ed)
{
  if (window.tinyMCE.activeEditor != ed)
  {
    alert("Please click on the area of the editor where you would like to insert this picture before opening the picture manager");
  }
  else
  {
    var manager = document.getElementById("pictureManager");
    myLytebox.start(manager, false, true);
  }
}

function documentManager(ed)
{
  ed.focus();
  bookmark = ed.selection.getBookmark();
  var originalElement = window.tinyMCE.activeEditor.selection.getStart();
  var element = window.tinyMCE.activeEditor.selection.getStart();
  // Check that user has right editor selected
	if (window.tinyMCE.activeEditor != ed) {
    alert("Please click on the area of the editor where you would like to insert this link before opening the link manager");
    return;
  }	
	var selection = window.tinyMCE.activeEditor.selection.getContent();
	if (selection != "")	{
  	var manager = document.getElementById("documentManager");
	  linkText = selection;
	  // Open the link manager elements link in lyteframe
	  myLytebox.start(manager, false, true);
	  return;
	}
	else
  {
    alert("Please select an element to turn into a link.");    
  }
}

function linkManager(ed) 
{
  links = [];
  ed.focus();
	var manager = document.getElementById("linkManager");
	var selectedElement = null;
	linkText = '';
	
  // Check that user has right editor selected
	if (window.tinyMCE.activeEditor != ed) 
	{
    alert("Please click on the area of the editor where you would like to insert this link before opening the link manager");
    return;
  }
  
  // Catch a click in a link, or a selection in the middle of a link
  selectedElement = ed.selection.getNode();
  do
  {
    if (selectedElement.href != undefined)
    {
      // select the whole link, since the selection was in it or a part of it
      linkText = outerHTML(selectedElement);
      ed.selection.select(selectedElement, false);
    }
    selectedElement = selectedElement.parentNode;
  }
  while (selectedElement != null)  
  
  // Catch a whole link being selected (and any additional text)
  if (linkText == '')
  {
    linkText = ed.selection.getContent();
  }
  
  if (linkText == '')
  {
    alert('Please select text to make into a link.')
    return;
  }
  
  bookmark = ed.selection.getBookmark();
  myLytebox.start(manager, false, true);
  return;
}

function outerHTML(node)
{
  // if IE, Chrome take the internal method otherwise build one
  return node.outerHTML || (
      function(n){
          var div = document.createElement('div'), h;
          div.appendChild( n.cloneNode(true) );
          h = div.innerHTML;
          div = null;
          return h;
      })(node);
}
