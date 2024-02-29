<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  
      <nav>
        <RouterLink to="/">GépAdatok</RouterLink><br>
        <RouterLink to="/about">Home</RouterLink><br>
        <RouterLink to="/ujgep">Új GépAdatok</RouterLink>

      </nav>
  
  <RouterView />
</template>

<style scoped>

</style>
