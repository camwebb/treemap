function insidewood(genus) {
  // See: http://stackoverflow.com/questions/133925/javascript-post-request-like-a-form-submit
  var form = document.createElement("form");
  form.setAttribute("method", "post");
  form.setAttribute("action", "http://insidewood.lib.ncsu.edu/?wicket:interface=:107:keywordsearchform::IFormSubmitListener::");
  
  var hiddenField = document.createElement("input");
  hiddenField.setAttribute("type", "hidden");
  hiddenField.setAttribute("name", "id2c91_hf_0");
  form.appendChild(hiddenField);
  
  var kw = document.createElement("input");
  kw.setAttribute("type", "hidden");
  kw.setAttribute("name", "keywordSearch");
  kw.setAttribute("value", genus);
  form.appendChild(kw);
  
  document.body.appendChild(form);
  form.submit();
}


// From insidewood search page: <form id="id2c91" method="post" action="?wicket:interface=:107:keywordsearchform::IFormSubmitListener::"><div style="display:none"><input type="hidden" name="id2c91_hf_0" id="id2c91_hf_0" /></div>
//			Example: Gasson
//			<textarea style="overflow: hidden; height:37px; width:100%" name="keywordSearch"></textarea>
//			<input type="submit" value="Search" name="keywordsearchbutton" id="id2c92"/>			
// 			</form>
