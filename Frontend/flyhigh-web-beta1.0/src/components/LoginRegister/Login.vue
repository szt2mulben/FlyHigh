<template>
    <div class="font-[sans-serif] text-[#333]">
  <div class="min-h-screen flex fle-col items-center justify-center py-6 px-4">
    <div class="grid md:grid-cols-2 items-center gap-10 max-w-6xl w-full">
      <div data-aos="fade-right" class="max-md:text-center">
            <h2 class="lg:text-5xl text-4xl font-extrabold lg:leading-[55px]">
              Üdvözöl téged a Flyhigh csapata!
            </h2>
            <p class="text-sm mt-6">Célunk hogy repülési élménye kimagasló legyen, hisz az Önök elégedettsége a szívügyünk! Jelentkezz be, hisz álomutazásod pár kattintsára...</p>
          </div>

    <form v-if="!showRegisterForm">
      <h2 v-if="!showRegisterForm" class="text-3xl font-extrabold mb-8 max-md:text-center">Bejelentkezés</h2>
      <input type="text" v-model="loginData.name" class="bg-gray-100 w-full text-sm px-4 py-3.5 rounded-md outline-blue-600" placeholder="Felhasználónév" required>
      <input type="password" v-model="loginData.password" class="bg-gray-100 w-full text-sm px-4 py-3.5 rounded-md outline-blue-600" placeholder="Jelszó" required>
      <button type="submit" class="w-full shadow-xl py-2.5 px-4 text-sm font-semibold rounded text-white bg-blue-600 hover:bg-blue-700 focus:outline-none" @click.prevent="login()">Bejelentkezés</button>
      <p class="py-2.5">Még nem regisztráltál? <a href="#" @click="showRegisterForm = true" class="font-bold	 text-blue-600 hover:text-blue-500">Regisztráció</a></p>
    </form>

    <form v-if="showRegisterForm">
      <h2 v-if="showRegisterForm" class="text-3xl font-extrabold mb-8 max-md:text-center">Regisztráció</h2>
      <input type="text" v-model="registerData.name" class="bg-gray-100 w-full text-sm px-4 py-3.5 rounded-md outline-blue-600" placeholder="Felhasználónév" required>
      <input type="password" v-model="registerData.password" class="bg-gray-100 w-full text-sm px-4 py-3.5 rounded-md outline-blue-600" placeholder="Jelszó" required>
      <input type="email" v-model="registerData.email" class="bg-gray-100 w-full text-sm px-4 py-3.5 rounded-md outline-blue-600" placeholder="E-mail:" required>
      <button type="submit" class="w-full shadow-xl py-2.5 px-4 text-sm font-semibold rounded text-white bg-blue-600 hover:bg-blue-700 focus:outline-none" @click="register()">Regisztráció</button>
      <p class="py-2.5">Már regisztráltál? <a href="#" class="font-bold text-blue-600 hover:text-blue-500" @click="showRegisterForm = false">Bejelentkezés</a></p>
    </form>
  </div>
  </div>
</div>
</template>

<script setup>
import axios from 'axios';
import { useRouter } from 'vue-router';
import { ref } from 'vue';

const router = useRouter();
const loginData = {
  name: '',
  password: '',
};
const registerData = {
  name: '',
  password: '',
  email: '',
};
const showRegisterForm = ref(false);

const login = async () => {
  try {
    const response = await axios.post(`https://localhost:7151/api/Useradatok/login`, {
      'Name': loginData.name,
      'Password': loginData.password,
    });

    const tokens = response.data.Token || response.data.token;

    if (response.status === 200) {
      localStorage.setItem('token', tokens);
      router.push('/');


    } else {
      console.log('Hiba: Sikertelen beléptetés');
    }
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
      'Permission' : "Ugyfel"
    });

    if (response.status === 200) {
      showRegisterForm.value = false;
    } else {
      console.log('Hiba: Sikertelen beléptetés');
    }
  } catch (error) {
    console.error('Hiba:', error);
  }
};
</script>

<style scoped>
.container {
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #f9f9f9;
}

h2 {
  margin-top: 0;
  margin-bottom: 20px;
}

form {
  margin-bottom: 20px;
}

input[type="text"],
input[type="password"],
input[type="email"] {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  box-sizing: border-box;
}

button {
  width: 100%;
  padding: 10px;
  border: none;
  border-radius: 5px;
  background-color: #007bff;
  color: #fff;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}

a {
  text-decoration: none;
  color: #007bff;
}

a:hover {
  text-decoration: underline;
}
</style>
