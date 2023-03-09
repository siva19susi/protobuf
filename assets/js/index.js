// MENU TOGGLE
function toggleMenu() {
  const menu = document.getElementsByClassName("menu")[0];
  const mcn = menu.className;
  const hideClass = "is-hidden";
  if(mcn.includes(hideClass)) {
    menu.classList.remove(hideClass)
  } else {
    menu.classList.add(hideClass)
  }
}

// HIDE MENU on MENU ENTRY click
const service = document.getElementsByClassName("service");
const menuItem = document.getElementsByClassName("list-item");
Array.from(service).forEach(el => el.addEventListener("click", toggleMenu));
Array.from(menuItem).forEach(el => el.addEventListener("click", toggleMenu));

// JQUERY CASE INSENSITIVE CONTAINS
jQuery.expr[':'].contains = function(a, i, m) {
  return jQuery(a).text().toUpperCase()
    .indexOf(m[3].toUpperCase()) >= 0;
};

// SEARCH SIDE MENU
function searchSideMenu() {
  const searchKey = document.getElementById("search");
  const menuItem = document.querySelectorAll("list-item");
  var matches = $(".menu-list").find("li:contains(" + searchKey.value + ")");
  $("li", ".menu-list").not(matches).slideUp();
  matches.slideDown();
}