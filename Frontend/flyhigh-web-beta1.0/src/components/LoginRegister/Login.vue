<template>

  <div v-if="!showHome == true" class="relative flex flex-col-reverse py-16 lg:pt-0 lg:flex-col lg:pb-0">
    <div class="inset-y-0 top-0 right-0 z-0 w-full max-w-xl px-4 mx-auto md:px-0 lg:pr-0 lg:mb-0 lg:mx-0 lg:w-7/12 lg:max-w-full lg:absolute xl:px-0">
      <svg class="absolute left-0 hidden h-full text-white transform -translate-x-1/2 lg:block" viewBox="0 0 100 100" fill="currentColor" preserveAspectRatio="none slice">
        <path d="M50 0H100L50 100H0L50 0Z"></path>
      </svg>
      <img
        class="object-cover w-full h-56 rounded shadow-lg lg:rounded-none lg:shadow-none md:h-96 lg:h-full"
        src="https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg?auto=compress&amp;cs=tinysrgb&amp;dpr=2&amp;h=750&amp;w=1260"
        alt=""
      />
    </div>
    <div class="relative flex flex-col items-start w-full max-w-xl px-4 mx-auto md:px-0 lg:px-8 lg:max-w-screen-xl">
      <div class="mb-16 lg:my-40 lg:max-w-lg lg:pr-5">
        <p class="inline-block px-3 py-px mb-4 text-xs font-semibold tracking-wider text-teal-900 uppercase rounded-full bg-teal-accent-400">
          Flyhigh - Flight Solutions
        </p>
        <h2 class="mb-5 font-sans text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl sm:leading-none">
          Minden út egy kaland <br class="hidden md:block" /> -
          hadd legyenünk a vezetőid!
        </h2>
        <p class="pr-5 mb-5 text-base text-gray-700 md:text-lg">
          2023 óta a piacon, azért hogy ügyfeleink kényelmesen foglaljanak repülőjegyet kedvenc úticélukhoz.
        </p>
        <div class="flex items-center">
          <a
          @click="showHomes(); showHome = true"
           
            class="bg-blue-400 text-white inline-flex items-center h-12 px-6 mr-6 font-medium tracking-wide  rounded shadow-md"
          >
            Jegyvásárlás
        </a>
          <a target="_blank" href="https://booking.com" aria-label="" class="inline-flex items-center font-semibold">Hotelek</a>
        </div>
      </div>
    </div>
  </div>

    <div v-if="showHome == true" class="font-[sans-serif] text-[#333]">
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
      <p class="py-2.5">Még nem regisztráltál? <a href="#" @click="showRegisterForm = true" class="font-bold text-blue-600">Regisztráció</a></p>
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
const showHome = ref(false);

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

const showHomes = async () => {

    if (showHome.value == true) {
      showHome.value = true;
    } else {
      console.log('Hiba: Sikertelen beléptetés');
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
}

a:hover {
  text-decoration: underline;
}
</style>
