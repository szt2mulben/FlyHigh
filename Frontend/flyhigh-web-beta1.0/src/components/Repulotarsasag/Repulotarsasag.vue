<template>
    <div class="bg-gray-100 p-0 sm:p-12">
      <h2 class="text-4xl pt-2 font-bold mb-8 text-center" data-aos="fade-down">Repülőterek adatai</h2>
      <div class="mx-auto max-w-md px-6 py-12 bg-white border-0 shadow-lg sm:rounded-3xl flight-search">
        <h1 class="text-2xl font-bold mb-8">Repülőterek Adatai</h1>
        <div id="form" novalidate>
          <div class="relative z-0 w-full mb-5">
            <input type="text" v-model="kereses" @input="keresesValtozas()" placeholder="Keresés..." id="teszt" class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200">
          </div>
        </div>
      </div>
    </div>
    
    <div class="flex items-center justify-center mb-16 bg-gray-100">
      <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-4 xl:grid-cols-4">
        <div v-for="repuloter in megjelenitettRepuloterek" :key="repuloter.id" class="relative bg-white py-6 px-6 rounded-3xl w-64 shadow-xl">
          <div class="mt-8">
            <p class="text-xl font-semibold my-2">{{repuloter.lastName}}</p>
            <div class="flex space-x-2 text-gray-400 text-sm">
              <p>Születési dátum:</p>
              <p>{{repuloter.birthsDay}}</p>
            </div>
            <div class="flex space-x-2 text-gray-400 text-sm my-3">
              <p>Ország:</p>
              <p>{{repuloter.country}}</p>
            </div>
            <div class="border-t-2"></div>
    
            <div class="flex justify-between">
              <div class="my-2">
                <p class="font-semibold text-base mb-2">ID: <br> {{repuloter.id}}</p>
                <div class="flex space-x-2">
                </div>
              </div>
            </div>
            <div class="my-2">
              <div v-if="currentUserPermission === 'Admin'" class="text-base text-gray-400 font-semibold flex justify-between">
                <p class="font-bold text-gray-600"><button @click="showEditModal(repuloter)">Módosítás</button></p>
                
                <div class="text-base text-gray-400 font-semibold">
                  <p class="text-red-400"><button @click="deleteRepuloter(repuloter.id)">Törlés</button></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <div id="editModal" class="modal">
      <div class="modal-content">
        <span class="close" @click="hideEditModal">&times;</span>
        <h2 class="font-bold pb-2">Módosítás</h2>
        <form @submit.prevent="saveChanges">
          <label for="editedLastName">Vezetéknév: </label>
          <input class="border-2 border-gray-400 rounded-xl m-2" type="text" id="editedLastName" v-model="editedRepuloter.lastName" required> <br>
    
          <label for="editedBirthsDay">Születési dátum:</label>
          <input class="border-2 border-gray-400 rounded-xl m-1" type="date" id="editedBirthsDay" v-model="editedRepuloter.birthsDay" required><br>
    
          <label for="editedCountry">Ország:</label>
          <input class="border-2 border-gray-400 rounded-xl m-1" type="text" id="editedCountry" v-model="editedRepuloter.country" required><br>
    
          <button class="bg-gray-500 hover:bg-gray-700 mt-4 text-white font-bold py-2 px-4 rounded-full" type="submit">Mentés</button>
        </form>
      </div>
    </div>
    </template>
    
    <script setup>
    import axios from 'axios';
    import { onMounted, ref } from 'vue';
    import { parseToken, getPermissions, getUsername } from '../../utils/auth.js';
    
    const token = localStorage.getItem('token');
    const payload = parseToken(token);
    
    const user = getUsername(payload);
    const per = getPermissions(payload);
    
    const repuloterek = ref([]);
    const kereses = ref('');
    const megjelenitettRepuloterek = ref([]);
    const editedRepuloter = ref({});
    const currentUserPermission = ref('');
    
    onMounted(() => {
      axios.get('https://localhost:7151/api/Repuloter')
        .then(resp => {
          repuloterek.value = resp.data;
          megjelenitettRepuloterek.value = resp.data;
          currentUserPermission.value = per;
          console.log(resp.data[0].birthsDay)
        });
    });
    
    const keresesValtozas = async () => {
      if (kereses.value !== "") {
        try {
          const response = await axios.get(`https://localhost:7151/api/Repuloter/search/${kereses.value}`);
          megjelenitettRepuloterek.value = response.data;
        } catch (error) {
          console.error('Hiba történt a repülőterek keresése közben:', error);
        }
      } else {
        alert("Ne hagy üresen a mezőt.");
      }
    };
    
    const deleteRepuloter = (id) => {
      axios.delete(`https://localhost:7151/api/Repuloter/`+id)
        .then(() => {
          megjelenitettRepuloterek.value = megjelenitettRepuloterek.value.filter(repuloter => repuloter.id != id);
        })
        .catch(error => {
          console.error('Hiba történt a repülőtér törlése közben:', error);
        });
    };
    
    const showEditModal = (repuloter) => {
      editedRepuloter.value = { ...repuloter };
      const modal = document.getElementById('editModal');
      modal.style.display = 'block';
    };
    
    const hideEditModal = () => {
      const modal = document.getElementById('editModal');
      modal.style.display = 'none';
    };
    
    const saveChanges = async () => {
      try {
        await axios.put(`https://localhost:7151/api/Repuloter/${editedRepuloter.value.id}`, editedRepuloter.value);
        const index = megjelenitettRepuloterek.value.findIndex(repuloter => repuloter.id === editedRepuloter.value.id);
        if (index !== -1) {
          megjelenitettRepuloterek.value[index] = { ...editedRepuloter.value };
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
    
