// MENU TOGGLE
function toggleMenu() {
  const menu = document.getElementById("sideMenu");
  const mcn = menu.className;
  const hcn = "is-hidden-touch";
  const fadeIn = "animate__fadeInLeft";
  const fadeOut = "animate__fadeOutLeft";
  if(mcn.includes(fadeIn)) {
    menu.classList.remove(hcn);
    menu.classList.remove(fadeIn);
    menu.classList.add(fadeOut);
  } 
  else if(mcn.includes(fadeOut)) {
    menu.classList.remove(fadeOut)
    menu.classList.add(fadeIn);
  }
}

// HIDE MENU on MENU ENTRY click
const service = document.getElementsByClassName("service");
const menuItem = document.getElementsByClassName("list-item");
Array.from(service).forEach(el => el.addEventListener("click", toggleMenu));
Array.from(menuItem).forEach(el => el.addEventListener("click", toggleMenu));

/*
// NAVBAR TOGGLE
const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll(".navbar-burger"), 0);
$navbarBurgers.forEach( el => {
  el.addEventListener("click", () => {
    const target = el.dataset.target;
    const $target = document.getElementById(target);
    el.classList.toggle("is-active");
    $target.classList.toggle("is-active");
  });
});
*/

function searchSideMenu() {
  const searchKey = document.getElementById("search");
  const menuItem = document.querySelectorAll("list-item");
  var matches = $(".menu-list").find("li:contains(" + searchKey.value + ")");
  $("li", ".menu-list").not(matches).slideUp();
  matches.slideDown();
}