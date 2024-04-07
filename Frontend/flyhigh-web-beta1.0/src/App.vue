<script setup>
import { RouterLink, RouterView } from 'vue-router'
import { ref } from 'vue';
import { parseToken, getUsername, getPermissions, logout } from './utils/auth.js';

const token = localStorage.getItem('token');
const payload = parseToken(token);

const user = getUsername(payload);
const per = getPermissions(payload);
const isLoggedIn = ref(!!user);

</script>


<template>
  <div v-if="isLoggedIn" class="bg-gray-800">
    <div style="float: right;">
  <div class="dropdown" v-if="payload && user">
    <span class="dropdown-toggle text-white">Bejelentkezve <b>{{ user }}</b> néven.</span>
  </div>
  <div class="dropdown" v-else>
    <span class="dropdown-toggle">Bejelentkezés</span>
    <div class="dropdown-menu" style="right: 0;">
      <RouterLink to="/loginregister">Bejelentkezés</RouterLink>
    </div>
  </div>
</div>
    

    <div class="dropdown">
    </div>
  </div>

  <section class="relative mx-auto">
    <nav class="flex justify-between bg-gray-900 text-white w-screen-75">
      <div class="px-5 xl:px-12 py-6 flex w-full items-center">
        <a class="text-3xl font-bold font-heading" href="/jegyadatok">
          <!-- <img class="h-9" src="logo.png" alt="logo"> -->
          Flyhigh
        </a>
        <ul class="hidden md:flex px-4 mx-auto font-semibold font-heading space-x-12">
          <li><a class="hover:text-gray-200" href="#"><RouterLink to="/jegyadatok">Kezdőlap</RouterLink></a></li>
          <li><a class="hover:text-gray-200" href="#"><RouterLink to="/felhasznaloiadatok">Jogosultságok</RouterLink></a></li>
          <li><a class="hover:text-gray-200" href="#"><div class="dropdown">
      <span class="dropdown-toggle">Légijáratok</span>
      <div class="dropdown-menu">
        <RouterLink to="/ujgep">Új GépAdatok</RouterLink>
        <RouterLink to="/gepadatok">GépAdatok</RouterLink>
        <RouterLink to="">Repülőtér</RouterLink>
        <RouterLink to="">Repülőtársaság</RouterLink>
      </div>
    </div></a></li>
        </ul>
        <div class="hidden xl:flex items-center space-x-5">
          <a class="dropdown flex items-center hover:text-gray-200" href="#">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 dropdown-toggle hover:text-gray-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
      <div class="dropdown-menu">
        <span class="text-black" @click="logout()" style="margin: 20px;">Kijelentkezés</span>
      <RouterLink to="/sajatadatok">Saját adatok</RouterLink></div>
          </a>
          
          <a class="flex items-center hover:text-gray-200" href="#">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
            <span class="flex absolute -mt-5 ml-4">
              <span class="animate-ping absolute inline-flex h-3 w-3 rounded-full bg-pink-400 opacity-75"></span>
                <span class="relative inline-flex rounded-full h-3 w-3 bg-pink-500">
                </span>
              </span>
          </a>
        </div>
      </div>
      <a class="xl:hidden flex mr-6 items-center" href="#">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 hover:text-gray-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
        </svg>
        <span class="flex absolute -mt-5 ml-4">
          <span class="animate-ping absolute inline-flex h-3 w-3 rounded-full bg-pink-400 opacity-75"></span>
          <span class="relative inline-flex rounded-full h-3 w-3 bg-pink-500">
          </span>
        </span>
      </a>
      <a class="navbar-burger self-center mr-12 xl:hidden" href="#">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 hover:text-gray-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
      </a>
    </nav>
  </section>


  <RouterView />

  <div class=" bg-gray-900">
    <div class="max-w-2xl mx-auto text-white py-10">
        <div class="text-center">
            <h3 class="text-3xl mb-3"> Próbáltad már Appjainkat? </h3>
            <p> Flyhigh - Flight Solutions. </p>
            <div class="flex justify-center my-10">
                <div class="flex items-center border w-auto rounded-lg px-4 py-2 w-52 mx-2">
                    <img src="https://cdn-icons-png.flaticon.com/512/888/888857.png" class="w-7 md:w-8">
                    <div class="text-left ml-3">
                        <p class='text-xs text-gray-200'>Download on </p>
                        <p class="text-sm md:text-base"> Google Play Store </p>
                    </div>
                </div>
                <div class="flex items-center border rounded-lg px-4 py-2 w-44 mx-2">
                    <img src="https://cdn-icons-png.flaticon.com/512/888/888841.png" class="w-7 md:w-8">
                    <div class="text-left ml-3">
                        <p class='text-xs text-gray-200'>Download on </p>
                        <p class="text-sm md:text-base"> Apple Store </p>
                    </div>
                </div>
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
