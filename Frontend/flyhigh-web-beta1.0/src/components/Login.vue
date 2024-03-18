<template>
  <div class="container">
    <h2 v-if="!showRegisterForm">Bejelentkezés</h2>
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


<script setup>
import axios from 'axios';
import { useRouter } from 'vue-router';
import { onMounted, ref } from 'vue';

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
    const userek = ref([]);

    onMounted(() => {
    axios.get('https://localhost:7151/api/Useradatok')
    .then(resp => {
        userek.value = resp.data;
    });
  });

  const login = async () => {
    try{
       const response =  await axios.post(`https://localhost:7151/api/Useradatok/login`, {
            'Name': loginData.name,
            'Password': loginData.password,
        });
        router.push('/home');
    }catch (error) {
        console.error('Hiba:', error);
    }
    // const data = response.data.success;
    // console.log(data)
    // if (data == true) {
    //   alert("Sikeres belépés")
    //   setTimeout(() => {
    //       router.push("/home");
    //   }, 100);
    // } else {
    //     alert('Hiba: Sikertelen belépés');
    // }
};



const register = async () => {
    try {
      console.log("registercucc")
        const response = await axios.post(`https://localhost:7151/api/Useradatok/register`, {
            'Name': registerData.name,
            'Password': registerData.password,
            'Email': registerData.email,
            'Permission' : "Ügyfél"
        });

        const token = response.data.Token || response.data.token;
        if (!token) {
            console.log('Hiba: Token nem található a válaszban');
            return;
        }

        localStorage.setItem('regtoken', token);
        console.log(token);
        showRegisterForm.value = false;
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

