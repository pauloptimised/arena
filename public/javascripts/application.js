// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function commaJoin(element, string)
{
  if (element.value.length == 0)
  {
    newString = string;
  }
  else
  {
    newString = element.value
    newString = newString.gsub((", " + string), "");
    newString = newString.gsub((string + ", "), "");
    newString = newString + ", " + string;
    //Effect.Highlight(element);
  }
  element.value = newString;
}

function remove_fields(link)
{
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}

function add_fields(link, association, content) 
{
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}

function toggleClass(elem, className1,className2)
{
  elem.className = (elem.className == className1)?className2:className1;
}

function toggleDiv(linkElem, divId, down, up)
{
  //Effect.toggle(divId, 'slide');
  element = document.getElementById(divId)
  element.style.display = (element.style.display == "none")?"":"none";
  toggleClass(linkElem, down, up);
}

function simpleToggle(element)
{
  element.style.display = (element.style.display == "none")?"":"none";
}

function fireEvent(element,event)
{
  if (document.createEventObject)
  {
    // dispatch for IE
    var evt = document.createEventObject();
    return element.fireEvent('on'+event,evt)
  }
  else
  {
    // dispatch for firefox + others
    var evt = document.createEvent("HTMLEvents");
    evt.initEvent(event, true, true ); // event type,bubbling,cancelable
    return !element.dispatchEvent(evt);
  }
}
