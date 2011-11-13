function insidewood(genus) {
  // See: http://stackoverflow.com/questions/133925/javascript-post-request-like-a-form-submit

  location.href="http://insidewood.lib.ncsu.edu/search";
  var form = document.createElement("form");
  form.setAttribute("method", "post");
  // form.setAttribute("action", "http://insidewood.lib.ncsu.edu/?wicket:interface=:71:keywordsearchform::IFormSubmitListener::");
  // XXX form.setAttribute("action", "http://insidewood.lib.ncsu.edu/search.0;jsessionid=d1fc69fc466a90ac4430e7f6e82c?wicket:interface=:0:keywordsearchform::IFormSubmitListener::");
  form.setAttribute("action", "http://insidewood.lib.ncsu.edu/search.0?wicket:interface=:0:keywordsearchform::IFormSubmitListener::");
  // form.setAttribute("action", "http://insidewood.lib.ncsu.edu/search.0?wicket:interface=:0:keywordsearchform::IFormSubmitListener::");


  var hiddenField = document.createElement("input");
  hiddenField.setAttribute("type", "hidden");
  hiddenField.setAttribute("name", "id7_hf_0");
  // form.appendChild(hiddenField);
  
  var kw = document.createElement("input");
  kw.setAttribute("type", "hidden");
  kw.setAttribute("name", "keywordSearch");
  kw.setAttribute("value", genus);
  form.appendChild(kw);
  
  document.body.appendChild(form);
  // document.cookie = "JSESSIONID=b1fc69fc466a90ac4430e7f6e82c; Path=/" ;
  form.submit();
}


// From insidewood search page: <form id="id2c91" method="post" action="?wicket:interface=:107:keywordsearchform::IFormSubmitListener::"><div style="display:none"><input type="hidden" name="id2c91_hf_0" id="id2c91_hf_0" /></div>
//			Example: Gasson
//			<textarea style="overflow: hidden; height:37px; width:100%" name="keywordSearch"></textarea>
//			<input type="submit" value="Search" name="keywordsearchbutton" id="id2c92"/>			
// 			</form>
