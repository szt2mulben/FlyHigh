<script setup>
import { RouterLink, RouterView } from 'vue-router'
import { ref } from 'vue';
import { parseToken, getUsername, getPermissions, logout } from './utils/auth.js';

const token = localStorage.getItem('token');
const payload = parseToken(token);

const user = getUsername(payload);
const per = getPermissions(payload);


</script>

<template>
  <nav>
    <div style="float: right;">
  <div class="dropdown" v-if="payload && user">
    <span class="dropdown-toggle">{{ user }}</span>
    <div class="dropdown-menu" style="right: 0;">
      <span @click="logout()">Kijelentkezés</span>
      <RouterLink to="/felhasznaloiadatok">Felhasználói adatok</RouterLink>
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
      <span class="dropdown-toggle">Felhasználók</span>
      <div class="dropdown-menu">
        <RouterLink to="/ujgep">Teszt</RouterLink>
      </div>
    </div>
    <div class="dropdown">
      <span class="dropdown-toggle">Légijáratok</span>
      <div class="dropdown-menu">
        <RouterLink to="/ujgep">Új GépAdatok</RouterLink>
        <RouterLink to="/home">GépAdatok</RouterLink>
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
