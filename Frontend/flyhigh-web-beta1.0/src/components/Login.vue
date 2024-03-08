<template>
  <div>
    <h2>Bejelentkezés</h2>
    <form v-if="!showRegisterForm">
      <input type="text" v-model="loginData.name" placeholder="Felhasználónév" required>
      <input type="password" v-model="loginData.password" placeholder="Jelszó" required>
      <button type="submit" @click="login()">Bejelentkezés</button>
      <p>Még nem regisztráltál? <a href="#" @click="showRegisterForm = true">Regisztráció</a></p>
    </form>

    <h2 v-if="showRegisterForm">Regisztráció</h2>
    <form v-if="showRegisterForm">
      <input type="text" v-model="registerData.name" placeholder="Felhasználónév" required>
      <input type="password" v-model="registerData.password" placeholder="Jelszó" required>
      <input type="email" v-model="registerData.email" placeholder="E-mail:" required>
      <button type="submit" @click="register()">Regisztráció</button>
      <p>Már regisztráltál? <a href="#" @click="showRegisterForm = false">Bejelentkezés</a></p>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import { useRouter } from 'vue-router';
import { onMounted, ref } from 'vue';

export default {
  setup() {
    const router = useRouter();
    const loginData = {
      name: '',
      password: ''
    };
    const registerData = {
      name: '',
      password: '',
      email: ''
    };


    const lastId = ref('');
    const showRegisterForm = ref(false);
    const userek = ref([]);

    onMounted(() => {
    axios.get('https://localhost:7151/api/Useradatok')
    .then(resp => {
        userek.value = resp.data;
    });
  });


  const login = async () => {
    try {
        const response = await axios.post(`https://localhost:7151/api/Useradatok/login`, {
            'Name': loginData.name,
            'Password': loginData.password,
        });
        const token = response.data.Token || response.data.token;
        if (!token) {
            console.error('Hiba: Token nem található a válaszban');
            return;
        }
        console.log(token);
        localStorage.setItem('logtoken', token);
        router.push('/home');
    } catch (error) {
        console.error('Hiba:', error);
    }
};


const register = async () => {
    try {
        const response = await axios.post(`https://localhost:7151/api/Useradatok/register`, {
            'Name': registerData.name,
            'Password': registerData.password,
            'Email': registerData.email,
        });

        const token = response.data.Token || response.data.token;
        if (!token) {
            console.error('Hiba: Token nem található a válaszban');
            return;
        }

        localStorage.setItem('regtoken', token);
        console.log(localStorage.getItem('regtoken'));
        showRegisterForm.value = false;
    } catch (error) {
        console.error('Hiba:', error);
    }
};



    return { login, register, loginData, registerData, showRegisterForm };
  }
};
</script>
