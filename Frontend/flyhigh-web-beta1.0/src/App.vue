<script setup>
import { RouterLink, RouterView } from 'vue-router'
import { ref } from 'vue';
import { parseToken, getUsername, getPermissions, logout } from './utils/auth.js';

const token = localStorage.getItem('token');
const payload = parseToken(token);

const user = getUsername(payload);
const per = getPermissions(payload);
const isLoggedIn = ref(!!user);

document.addEventListener('DOMContentLoaded', function() {
    const burger = document.querySelectorAll('.navbar-burger');
    const menu = document.querySelectorAll('.navbar-menu');

    if (burger.length && menu.length) {
        for (var i = 0; i < burger.length; i++) {
            burger[i].addEventListener('click', function() {
                for (var j = 0; j < menu.length; j++) {
                    menu[j].classList.toggle('hidden');
                }
            });
        }
    }

    const close = document.querySelectorAll('.navbar-close');
    const backdrop = document.querySelectorAll('.navbar-backdrop');

    if (close.length) {
        for (var i = 0; i < close.length; i++) {
            close[i].addEventListener('click', function() {
                for (var j = 0; j < menu.length; j++) {
                    menu[j].classList.toggle('hidden');
                }
            });
        }
    }

    if (backdrop.length) {
        for (var i = 0; i < backdrop.length; i++) {
            backdrop[i].addEventListener('click', function() {
                for (var j = 0; j < menu.length; j++) {
                    menu[j].classList.toggle('hidden');
                }
            });
        }
    }
});

</script>


<template>
  <section class="relative mx-auto ">
    <nav class="flex justify-between bg-gray-900 text-white w-screen-75">
      <div class="px-5 xl:px-12 py-6 flex w-full items-center">
        <a class="text-3xl font-bold font-heading" href="/jegyadatok">
          Flyhigh
        </a>
        <ul class="hidden navbar-hamburger md:flex px-4 mx-auto font-semibold font-heading space-x-12">
          <li><a class="hover:text-gray-200" href="#"><RouterLink to="/jegyadatok">Kezdőlap</RouterLink></a></li>
          <li><a class="hover:text-gray-200" href="#"><RouterLink to="/felhasznaloiadatok">Jogosultságok</RouterLink></a></li>
          <li><a class="hover:text-gray-200" href="#"><div class="dropdown">
      <span class="dropdown-toggle">Légijáratok</span>
      <div class="dropdown-menu">
        <RouterLink to="/ujgep">Új GépAdatok</RouterLink>
        <RouterLink to="/gepadatok">GépAdatok</RouterLink>
        <RouterLink to="/repuloterek">Repülőtér</RouterLink>
      </div>
    </div></a></li>
    <li><a class="hover:text-gray-200" target="_blank" href="https://booking.com">Hotel</a></li>
        </ul>
        <div class="hidden xl:flex items-center space-x-5">
          <a class="dropdown flex items-center hover:text-gray-200" href="#">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 dropdown-toggle hover:text-gray-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
      <div class="dropdown-menu p-2 bg-gray-100 hover:bg-gray-200">
        <span class="text-black" @click="logout()">Kijelentkezés</span>
      </div>
          </a>
          
          <RouterLink to="/sajatadatok"><a class="flex items-center hover:text-gray-200" href="#">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
              
          </a></RouterLink>
        </div>
      </div>
      <a class="xl:hidden flex mr-6 items-center" href="#">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 hover:text-gray-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
        </svg>
      </a>
      <a class="navbar-burger self-center mr-12 xl:hidden" href="#">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 hover:text-gray-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
      </a>
    </nav>
  </section>
  <div class="navbar-menu relative z-50 hidden">
		<div class="navbar-backdrop fixed inset-0 bg-gray-800 opacity-25"></div>
		<nav class="fixed top-0 left-0 bottom-0 flex flex-col w-5/6 max-w-sm py-6 px-6 bg-white border-r overflow-y-auto">
			<div class="flex items-center mb-8">
				<a class="mr-auto text-3xl font-bold leading-none" href="#">
				<h1 class="font-bold">Flyhigh</h1>
				</a>
				<button class="navbar-close">
					<svg class="h-6 w-6 text-gray-400 cursor-pointer hover:text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
					</svg>
				</button>
			</div>
			<div>
				<ul>
					<li class="mb-1">
						<RouterLink to="/jegyadatok" class="block p-4 text-sm font-semibold text-gray-400 hover:bg-gray-100">Kezdőlap</RouterLink>
					</li>
					<li class="mb-1">
						<RouterLink to="/felhasznaloiadatok" class="block p-4 text-sm font-semibold text-gray-400 hover:bg-gray-100">Jogosultságok</RouterLink>
					</li>
          <li class="mb-1">
						<RouterLink to="/ujgep" class="block p-4 text-sm font-semibold text-gray-400 hover:bg-gray-100">Új GépAdatok</RouterLink>
					</li>
          <li class="mb-1">
						<RouterLink to="/gepadatok" class="block p-4 text-sm font-semibold text-gray-400 hover:bg-gray-100">GépAdatok</RouterLink>
					</li>
					<li class="mb-1">
						<RouterLink to="/repuloterek"  class="block p-4 text-sm font-semibold text-gray-400 hover:bg-gray-100">Repülőtér</RouterLink>
					</li>
          <li class="mb-1">
            <a  class="block p-4 text-sm font-semibold text-gray-400 hover:bg-gray-100" target="_blank" href="https://booking.com">Hotel</a>
          </li>
          <li class="mb-1">
            <RouterLink to="/sajatadatok" class="block p-4 text-sm font-semibold text-gray-400 hover:bg-gray-100">Személyes Adatok</RouterLink>
          </li>
          <li class="mb-1">
            <a  class="block p-4 text-sm font-semibold text-gray-400 hover:bg-gray-100" href="#"> <span  @click="logout()" >Kijelentkezés</span></a>
          </li>
				</ul>
			</div>
		</nav>
	</div>

  <RouterView />

  <div class=" bg-gray-900">
    <div class="max-w-2xl mx-auto text-white py-10">
        <div class="text-center">
            <h3 class="text-2xl mb-3"> Iratkozzon fel hírlevelünkre! </h3>
            <p class="text-gray-300"> Légy naprakész. </p>
            <div class="flex justify-center mt-14 my-4">
              <form class="mt-2">
        <div class="relative max-w-lg">
          <label class="sr-only" for="email"> Email </label>

          <input
            class="rounded-full text-black border-gray-200 bg-gray-100 p-4 pe-32 text-sm font-medium"
            id="email"
            type="email"
            placeholder="ugyfel@flyhighdev.hu"
          />

          <button
            class="absolute end-1 top-1/2 -translate-y-1/2 rounded-full bg-blue-600 px-5 py-3 text-sm font-medium text-white transition hover:bg-blue-700"
          >
             Feliratkozás
          </button>
        </div>
      </form>
      </div>
        </div>
        <div class="mt-28 flex flex-col md:flex-row md:justify-between items-center text-sm text-gray-400">
            <p class="order-2 md:order-1 mt-8 md:mt-0"> &copy; Flyhigh, 2024. </p>
            <div class="order-1 md:order-2">
                <span class="px-2">Rólunk</span>
                <span class="px-2 border-l">Kapcsolat</span>
                <span class="px-2 border-l">Adatkezelés</span>
            </div>
        </div>
    </div>
</div>
</template>

<style scoped>
.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-toggle {
  cursor: pointer;
}

.dropdown-menu {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-menu a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown:hover .dropdown-menu {
  display: block;
}

</style>
