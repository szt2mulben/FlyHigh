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
        <button type="submit">Regisztráció</button>
        <p>Már regisztráltál? <a href="#" @click="showRegisterForm = false">Bejelentkezés</a></p>
      </form>
    </div>
  </template>
  
  <script>
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
        password: ''
      }
    };
  },
  methods: {
    async login() {
      try {
        const response = await axios.post('https://localhost:7151/api/login', this.loginData);
        console.log(response.data);
      } catch (error) {
        console.error('Hiba történt:', error);
      }
    },
    async register() {
      try {
        const response = await axios.post('https://localhost:7151/api/register', this.registerData);
        console.log(response.data);
      } catch (error) {
        console.error('Hiba történt:', error);
      }
    }
  }
};
</script>
  