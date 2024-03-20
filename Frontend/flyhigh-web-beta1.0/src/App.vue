<script>
import { computed } from 'vue'
import { useStore } from 'vuex'

export default {
  setup() {
    const store = useStore()
    const loggedInUser = computed(() => store.state.isLoggedIn)

    return { loggedInUser }
  }
}
</script>


<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <nav>
    <div class="dropdown" v-if="loggedInUser">
      <span class="dropdown-toggle">{{ loggedInUser }}</span>
      <div class="dropdown-menu">
        <button @click="logout">Kijelentkezés</button>
      </div>
    </div>
    <div class="dropdown" v-else>
      <span class="dropdown-toggle">Bejelentkezés</span>
      <div class="dropdown-menu">
        <RouterLink to="/loginregister">Bejelentkezés</RouterLink>
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
