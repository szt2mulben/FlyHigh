<template> 
     <div>
    <h1>Gép felvétele:</h1>
    <div class="gep-container">
      <div class="gep-card">
        <div class="info">
          <p><span>Gép neve:</span> <input type="text" v-model="nev"></p>
          <p><span>Foglalt turista:</span> <input type="text" v-model="fturista"></p>
          <p><span>Foglalt elsőosztály:</span> <input type="text" v-model="fElso"></p>
          <p><span>ELsőosztály ulohelyek:</span> <input type="text" v-model="Eulo"></p>
          <p><span>Turistaulohelyek:</span> <input type="text" v-model="Tulo"></p>
          <button @click="saveData()">Mentés</button>
        </div>
      </div>
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
  