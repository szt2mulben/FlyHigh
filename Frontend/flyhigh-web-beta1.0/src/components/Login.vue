<template>
  <div>
    <h2>Bejelentkezés</h2>
    <form v-if="!showRegisterForm" @submit.prevent="login">
      <input type="text" v-model="loginData.username" placeholder="Felhasználónév" required>
      <input type="password" v-model="loginData.password" placeholder="Jelszó" required>
      <button type="submit">Bejelentkezés</button>
      <p>Még nem regisztráltál? <a href="#" @click="showRegisterForm = true">Regisztráció</a></p>
    </form>

    <h2 v-if="showRegisterForm">Regisztráció</h2>
    <form v-if="showRegisterForm" @submit.prevent="register">
      <input type="text" v-model="registerData.username" placeholder="Felhasználónév" required>
      <input type="password" v-model="registerData.password" placeholder="Jelszó" required>
      <input type="email" v-model="registerData.email" placeholder="E-mail:" required>
      <button type="submit">Regisztráció</button>
      <p>Már regisztráltál? <a href="#" @click="showRegisterForm = false">Bejelentkezés</a></p>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import { useRouter } from 'vue-router';

export default {
  data() {
    return {
      showRegisterForm: false,
      loginData: {
        username: '',
        password: ''
      },
      registerData: {
        username: '',
        password: '',
        email: ''
      }
    };
  },
  setup() {
    const router = useRouter();

    const login = async function() {
      try {
        const response = await axios.post('https://localhost:7151/api/login', this.loginData);
        const token = response.data.token;
        localStorage.setItem('token', token); 
        router.push('/home'); 
      } catch (error) {
        console.error('Hiba történt:', error);
      }
    };

    const register = async function() {
      try {
        const response = await axios.post('https://localhost:7151/api/register', this.registerData);
        const token = response.data.token;
        localStorage.setItem('token', token);
        showRegisterForm = false;
      } catch (error) {
        console.error('Hiba történt:', error);
      }
    };

    return { login, register };
  }
};
</script>
