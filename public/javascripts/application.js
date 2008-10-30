// Common JavaScript code across your application goes here.
$(function() {
  $("#navcontainer:has(li) ul").each(function() {
    $(this).tabs();
    var index = $("li[selected=selected] a", this).attr("href");
    $(this).data("tabs").select(index);
  });
});