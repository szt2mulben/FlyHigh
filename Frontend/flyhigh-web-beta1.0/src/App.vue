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
  <nav>
  <div v-if="isLoggedIn">
    <div style="float: right;">
  <div class="dropdown" v-if="payload && user">
    <span class="dropdown-toggle">Bejelentkezve <b>{{ user }}</b> néven.</span>
    <div class="dropdown-menu" style="right: 0;">
      <span @click="logout()" style="margin: 20px;">Kijelentkezés</span>
      <RouterLink to="/sajatadatok">Saját adatok</RouterLink>
    </div>
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
  </nav>

  <nav class="bg-white border-gray-200 shadow ">
  <div class="max-w-screen-2xl py-2.5 flex flex-wrap items-center justify-between mx-auto">
    <a href="/jegyadatok" class="flex items-center space-x-3 rtl:space-x-reverse">
        <img src="https://cdn.discordapp.com/attachments/919994217584013343/1225201951650877460/flyhigh_color_logo.png?ex=6620453c&is=660dd03c&hm=0bb848317b5ac2c41dc4b601aa48a87413b42b5f05e23ba15aa0b3e482723526&" class="h-12" alt="Flyhigh Logo" />
    </a>
    <button data-collapse-toggle="navbar-default" type="button" class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-default" aria-expanded="false">
        <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15"/>
        </svg>
    </button>
    <div class="hidden w-full md:block md:w-auto" id="navbar-default">
      <ul class="font-medium flex flex-col p-4 md:p-0 mt-4 border rounded-lg  md:flex-row md:space-x-8 rtl:space-x-reverse md:mt-0 md:border-0">
        <li>
          <a href="#" class="block py-2 px-3 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-0 dark:text-white md:dark:text-blue-500" aria-current="page"><RouterLink to="/felhasznaloiadatok">Jogosultságok</RouterLink></a>
        </li>
        <li>
          <a href="#" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">    <div class="dropdown">
      <span class="dropdown-toggle">Légijáratok</span>
      <div class="dropdown-menu">
        <RouterLink to="/ujgep">Új GépAdatok</RouterLink>
        <RouterLink to="/gepadatok">GépAdatok</RouterLink>
        <RouterLink to="">Repülőtér</RouterLink>
        <RouterLink to="">Repülőtársaság</RouterLink>
      </div>
    </div></a>
        </li>
        <li>
          <a href="#" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent"><RouterLink to="/jegyadatok">Jegyek</RouterLink></a>
        </li>

      </ul>
    </div>
  </div>
</nav>

  <RouterView />
</template>

<style scoped>
.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-toggle {
  cursor: pointer;
  margin-right: 20px;
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
