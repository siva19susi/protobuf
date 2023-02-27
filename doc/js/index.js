// MENU TOGGLE
/*function toggleMenu() {
  const menu = document.getElementById("sideMenu");
  const mbtn = document.getElementById("menuButton");
  const mcn = menu.className;
  const animation = menu.style.animationName;
  if(animation == "" || animation == "fadeOutLeft") {
    menu.style.animationName = "fadeInLeft";
    mbtn.innerHTML = "<i class='bx bx-x bx-sm'></i>";
  } else {
    menu.style.animationName = "fadeOutLeft";
    mbtn.innerHTML = "<i class='bx bx-menu-alt-left bx-sm'></i>";
  }
}*/

function toggleMenu() {
  const menu = document.getElementsByClassName("menu")[0];
  const mcn = menu.className;
  const hideClass = "is-hidden-touch";
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

function searchSideMenu() {
  const searchKey = document.getElementById("search");
  const menuItem = document.querySelectorAll("list-item");
  var matches = $(".menu-list").find("li:contains(" + searchKey.value + ")");
  $("li", ".menu-list").not(matches).slideUp();
  matches.slideDown();
}