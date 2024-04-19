<template> 
  <div class=" bg-gray-100 p-0 sm:p-12 mb-8">
    <h2 class="text-4xl pt-2 font-bold mb-8 text-center" data-aos="fade-down">Új Adat</h2>

  <div class="mx-auto max-w-md px-6 py-12 bg-white border-0 shadow-lg sm:rounded-3xl flight-search ">
    <h1 class="text-2xl font-bold mb-8">Gép felvétele</h1>
    <div id="form" novalidate>
      <div class="relative z-0 w-full mb-5">
        <input type="text" v-model="nev" placeholder="Gép neve" class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200">
      </div>
     </div>

     <div id="form" novalidate>
      <div class="relative z-0 w-full mb-5">
        <input type="text" v-model="fturista" placeholder="Foglaló neve" class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200">
      </div>
     </div>

     <div id="form" novalidate>
      <div class="relative z-0 w-full mb-5">
        <input type="text" v-model="fElso" placeholder="Foglalt elsőosztály" class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200">
      </div>
     </div>

     <div id="form" novalidate>
      <div class="relative z-0 w-full mb-5">
        <input type="text" v-model="Eulo" placeholder="Első osztály ülőhelyek:" class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200">
      </div>
     </div>

     <div id="form" novalidate>
      <div class="relative z-0 w-full mb-5">
        <input type="text" v-model="Tulo" placeholder="Turista ülőhelyek:" class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200">
      </div>
     </div>
     <button class="w-full mt-4 p-1 text-lg text-white transition-all duration-150 ease-linear rounded-lg shadow outline-none bg-blue-600 hover:bg-pink-600 hover:shadow-lg focus:outline-none" @click="saveData()">Mentés</button>
  </div>
</div>

  </template>
  
  <script setup>
  import axios from 'axios';
  import { onMounted, ref } from 'vue';
  
  const megjelenitettGepadatok = ref([]);
  
const nev = ref('');
const fturista = ref('');
const fElso = ref('');
const Eulo = ref('');
const Tulo = ref('');
const lastId = ref('');

const saveData = () => {
  lastId.value = megjelenitettGepadatok.value[megjelenitettGepadatok.value.length-1].id * 1 + 1;

  axios.post('https://localhost:7151/api/Gepadatok', {

            'id' : String(lastId.value), 
            "Gepneve" : nev.value, 
            "Foglaltturista" : fturista.value,
            "Foglalt1oszt" : fElso.value,  
            "Elsoosztulohelyek" : Eulo.value, 
            "Turistaulohelyek" : Tulo.value,
          })
          
    .catch(error => {
      console.error('Adatok mentése sikertelen:', error);
    });
    lastId.value = '';

};
  onMounted(() => {
    axios.get('https://localhost:7151/api/Gepadatok')
    .then(resp => {
        megjelenitettGepadatok.value = resp.data;
    });
  });
  
  
  </script>
  
  <style scoped>
.flight-search {
  max-width: 75%;
  margin: 0 auto;
  margin-top:50px;
}

  .gep-container {
    display: flex;
    flex-wrap: wrap;
  }
  
  .gep-card {
    margin: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 200px;
  }
  
  .info {
    padding: 10px;
    background-color: #f0f0f0;
    border-bottom: 1px solid #ccc;
  }
  
  .info p {
    margin: 5px 0;
    font-weight: bold;
  }
  
  .search-container {
    margin-bottom: 20px;
  }
  </style>
  