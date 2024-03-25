<template> 
  <h1>Gépek Adatai:</h1>
  <div class="search-container">
    <p>Keresési kritérium:(Gép neve)</p>
    <input type="text" v-model="kereses" @input="keresesValtozas()" placeholder="Keresés..." id="teszt">
  </div>
  <div class="gep-container">
    <div v-for="gepek in megjelenitettGepadatok" :key="gepek.id" class="gep-card">
      <div class="info">
        <p><span>Gép neve:</span> {{gepek.gepneve}}</p>
        <p><span>Foglalt turista:</span> {{gepek.foglaltturista}}</p>
        <p><span>Foglalt elsőosztály:</span> {{gepek.foglalt1oszt}}</p>
        <p><span>ELsőosztály ulohelyek:</span> {{gepek.elsoosztulohelyek}}</p>
        <p><span>Turistaulohelyek:</span> {{gepek.turistaulohelyek}}</p>
        <!-- Gombok csak adminisztrátor esetén jelennek meg -->
        <p v-if="currentUserPermission === 'Admin'">
          <button @click="deletegep(gepek.id)">Törlés</button>
          <button @click="showEditModal(gepek)">Módosítás</button>
        </p>
      </div>
    </div>
  </div>
  
  <div id="editModal" class="modal">
    <div class="modal-content">
      <span class="close" @click="hideEditModal">&times;</span>
      <h2>Módosítás</h2>
      <form @submit.prevent="saveChanges">
        <label for="editedGepneve">Gép neve:</label>
        <input type="text" id="editedGepneve" v-model="editedGep.gepneve" required> <br>

        <label for="editedFoglaltturista">Foglalt turista:</label>
        <input type="number" id="editedFoglaltturista" v-model="editedGep.foglaltturista" required><br>

        <label for="editedFoglalt1oszt">Foglalt elsőosztály:</label>
        <input type="number" id="editedFoglalt1oszt" v-model="editedGep.foglalt1oszt" required><br>

        <label for="editedElsoosztulohelyek">Első osztályú ülések:</label>
        <input type="number" id="editedElsoosztulohelyek" v-model="editedGep.elsoosztulohelyek" required><br>

        <label for="editedTuristaulohelyek">Turista ülések:</label>
        <input type="number" id="editedTuristaulohelyek" v-model="editedGep.turistaulohelyek" required><br>

        <button type="submit">Mentés</button>
      </form>
    </div>
  </div>
</template>

<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';
import { parseToken, getPermissions,  getUsername } from '../../utils/auth.js';

const token = localStorage.getItem('token');
const payload = parseToken(token);

const user = getUsername(payload);
const per = getPermissions(payload);


const gepadatok = ref([]);
const kereses = ref('');
const megjelenitettGepadatok = ref([]);
const editedGep = ref({});
const currentUserPermission = ref('');

onMounted(() => {
  axios.get('https://localhost:7151/api/Gepadatok')
  .then(resp => {
      gepadatok.value = resp.data;
      megjelenitettGepadatok.value = resp.data;
      currentUserPermission.value = per;
  });
});

const keresesValtozas = async () => {
  if (kereses.value !== "") {
    try {
      const response = await axios.get(`https://localhost:7151/api/Gepadatok/search/${kereses.value}`);
      megjelenitettGepadatok.value = response.data;
    } catch (error) {
      console.error('Hiba történt a gépadatok keresése közben:', error);
    }
  } else {
    alert("Ne hagy üresen a mezőt.");
  }
};

const deletegep = (id) => {
  axios.delete('https://localhost:7151/api/Gepadatok/' + id)
  .then(() => {
    megjelenitettGepadatok.value = megjelenitettGepadatok.value.filter(meg => meg.id != id)
  });
};

const showEditModal = (gep) => {
  editedGep.value = { ...gep };
  const modal = document.getElementById('editModal');
  modal.style.display = 'block';
};

const hideEditModal = () => {
  const modal = document.getElementById('editModal');
  modal.style.display = 'none';
};

const saveChanges = async () => {
  try {
    await axios.put(`https://localhost:7151/api/Gepadatok/${editedGep.value.id}`, editedGep.value);
    const index = megjelenitettGepadatok.value.findIndex(gep => gep.id === editedGep.value.id);
    if (index !== -1) {
      megjelenitettGepadatok.value[index] = { ...editedGep.value };
    }
    hideEditModal();
  } catch (error) {
    console.error('Hiba történt a változtatások mentése közben:', error);
  }
};
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

.modal {
  display: none;
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: 10% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
</style>
