<template>
  <div class=" bg-gray-100 pb-6 sm:p-12">
    <h2 class="text-4xl pt-2 font-bold mb-8 text-center" data-aos="fade-down">Utazni készülsz? Segítünk!</h2>
  <div v-if="!bookingCompleted" class="flight-search px-6 py-12 bg-white border-0 shadow-lg sm:rounded-3xl">
    <h1 class="text-2xl font-bold mb-8">Repülőjegy foglalás</h1>
    <div id="form flight-search" novalidate>
      <div class="relative z-0 w-full mb-5">
        <select
         id="from" 
         v-model="from"
          onclick="this.setAttribute('value', this.value);"
          class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none z-1 focus:outline-none focus:ring-0 focus:border-black border-gray-200"
        >
          <option value="" selected disabled hidden></option>
          <option v-for="country in countries" :value="country.orszag_nev">{{ country.orszag_nev }}</option>
        </select>
        
        <label for="select" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Honnan utaznál?</label>
        <span class="text-sm text-red-600 hidden" id="error">Kérlek válaszd ki honnan utaznál</span>
      </div>

      <div class="relative z-0 w-full mb-5">
        <select
        id="to" 
        v-model="to"
          onclick="this.setAttribute('value', this.value);"
          class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none z-1 focus:outline-none focus:ring-0 focus:border-black border-gray-200"
        >
          <option value="" selected disabled hidden></option>
          <option v-for="country in countries" :value="country.orszag_nev">{{ country.orszag_nev }}</option>
        </select>
        
        <label for="select" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Hova szeretnél utazni?</label>
        <span class="text-sm text-red-600 hidden" id="error">Kérlek válaszd ki hova utaznál</span>
      </div>

      <div class="flex flex-row space-x-4">
        <div class="relative z-0 w-full mb-5">
          <input
          type="date" 
          id="departure" 
          v-model="departureTime"
            placeholder=" "
            class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200"
          />
          <label for="departure" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Utazás dátuma</label>
          <span class="text-sm text-red-600 hidden" id="error">Utazási dátum megadása kötelező</span>
        </div>
      </div>

      <div class="relative z-0 w-full mb-5">
        <input
        type="number" 
        id="passengers" 
        v-model="passengerCount"
          placeholder=" "
          class="pt-3 pb-2 pr-12 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200"
        />
        <div class="absolute top-0 right-0 mt-3 mr-4 text-gray-400">db</div>
        <label min="1" for="passengers" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Utasok száma</label>
        <span class="text-sm text-red-600 hidden" id="error">Add meg az utasok számát</span>
      </div>

      <fieldset class="relative z-0 w-full p-px mb-5">
        <legend class="absolute text-gray-500 transform scale-75 -top-3 origin-0">Osztály</legend>
        <div class="block pt-3 pb-2 space-x-4">
          <select id="class" v-model="flightClass">
            <option value="economy" class="mr-2 text-black border-2 border-gray-300 focus:border-gray-300 focus:ring-black">Economy</option>
            <option value="business" class="mr-2 text-black border-2 border-gray-300 focus:border-gray-300 focus:ring-black">Business</option>
          </select>
        </div>
        <span class="text-sm text-red-600 hidden" id="error">Jelöld ki az utazási osztályt</span>
      </fieldset>
      <button @click="searchFlights"
        class="w-full px-6 py-3 mt-3 text-lg text-white transition-all duration-150 ease-linear rounded-lg shadow outline-none bg-pink-500 hover:bg-pink-600 hover:shadow-lg focus:outline-none"
      >
      Keresés
      </button>
    </div>
  </div>
  <h2 v-if="bookingCompleted" class="text-4xl pt-2 font-bold mb-8 text-center">Jegyek</h2>
    <div v-if="searchResults.length > 0 " class="flight-search bg-white rounded-xl shadow-lg">
      <div class="p-10" v-for="(flight, index) in searchResults" :key="index">
  <div class="max-w-full  bg-white flex flex-col rounded overflow-hidden shadow-lg" data-aos="fade-up">
    <div class="flex flex-row items-baseline flex-nowrap bg-gray-100 p-2">
      <svg viewBox="0 0 64 64" data-testid="tripDetails-bound-plane-icon" pointer-events="all" aria-hidden="true" class="mt-2 mr-1" role="presentation" style="fill: rgb(102, 102, 102); height: 0.9rem; width: 0.9rem;">
        <path d="M43.389 38.269L29.222 61.34a1.152 1.152 0 01-1.064.615H20.99a1.219 1.219 0 01-1.007-.5 1.324 1.324 0 01-.2-1.149L26.2 38.27H11.7l-3.947 6.919a1.209 1.209 0 01-1.092.644H1.285a1.234 1.234 0 01-.895-.392l-.057-.056a1.427 1.427 0 01-.308-1.036L1.789 32 .025 19.656a1.182 1.182 0 01.281-1.009 1.356 1.356 0 01.951-.448l5.4-.027a1.227 1.227 0 01.9.391.85.85 0 01.2.252L11.7 25.73h14.5L19.792 3.7a1.324 1.324 0 01.2-1.149A1.219 1.219 0 0121 2.045h7.168a1.152 1.152 0 011.064.615l14.162 23.071h8.959a17.287 17.287 0 017.839 1.791Q63.777 29.315 64 32q-.224 2.685-3.807 4.478a17.282 17.282 0 01-7.84 1.793h-9.016z"></path>
      </svg>
      <h1 class="ml-2 uppercase font-bold text-gray-500">UTAZÁSI DÁTUM: {{ departureTime }}</h1>
    </div>
    <div class="mt-2 flex justify-start bg-white p-2">
      <div class="flex mx-2 ml-6 h8 px-2 flex-row items-baseline rounded-full bg-gray-100 p-1">
        <svg viewBox="0 0 64 64" pointer-events="all" aria-hidden="true" class="etiIcon css-jbc4oa" role="presentation" style="fill: rgb(102, 102, 102); height: 12px; width: 12px;">
          <path d="M43.389 38.269L29.222 61.34a1.152 1.152 0 01-1.064.615H20.99a1.219 1.219 0 01-1.007-.5 1.324 1.324 0 01-.2-1.149L26.2 38.27H11.7l-3.947 6.919a1.209 1.209 0 01-1.092.644H1.285a1.234 1.234 0 01-.895-.392l-.057-.056a1.427 1.427 0 01-.308-1.036L1.789 32 .025 19.656a1.182 1.182 0 01.281-1.009 1.356 1.356 0 01.951-.448l5.4-.027a1.227 1.227 0 01.9.391.85.85 0 01.2.252L11.7 25.73h14.5L19.792 3.7a1.324 1.324 0 01.2-1.149A1.219 1.219 0 0121 2.045h7.168a1.152 1.152 0 011.064.615l14.162 23.071h8.959a17.287 17.287 0 017.839 1.791Q63.777 29.315 64 32q-.224 2.685-3.807 4.478a17.282 17.282 0 01-7.84 1.793h-9.016z"></path>
        </svg>
        <p class="font-normal text-sm ml-1 text-gray-500">Economy/Business Trip</p>
      </div>
    </div>
    <div class="mt-2 flex sm:flex-row mx-6 sm:justify-between flex-wrap ">
      <div class="flex flex-row place-items-center p-2">
        <img alt="Qatar Airways" class="w-10 h-10" src="data:image/png;base64,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" style="opacity: 1; transform-origin: 0% 50% 0px; transform: none;" />
        <div class="flex flex-col ml-2">
          <p class="text-xs text-gray-500 font-bold">  Qatar Airways</p>
          <p class="text-xs text-gray-500">QA{{ generateRandomPrice() }}</p>
          <div class="text-xs text-gray-500">{{ generateRandomTwoNumber() }} kg</div>
        </div>
      </div>

      <div class="flex flex-col p-2">
        <p class="font-bold">{{ flight.departure }}</p>
        <p class="text-gray-500"><span class="font-bold">Indul innen:</span></p>
        <p class="text-gray-500">{{ flight.from }}</p>
      </div>
      <div class="flex flex-col flex-wrap p-2">
        <p class="font-bold">{{ flight.arrival }}</p>
        <p class="text-gray-500"><span class="font-bold">Érkezés:</span></p>
        <p class="text-gray-500">{{ flight.to }}</p>
      </div>
    </div>
    <div class="mt-4 bg-gray-100 flex flex-row flex-wrap md:flex-nowrap justify-between items-baseline">
      <div class="flex mx-6 py-4 flex-row flex-wrap">
      </div>
      <div class="md:border-l-2 mx-6 md:border-dotted flex flex-row py-4 mr-6 flex-wrap">
        <svg class="w-12 h-10 p-2 mx-2 self-center bg-gray-400 rounded-full fill-current text-white" viewBox="0 0 64 64" pointer-events="all" aria-hidden="true" role="presentation"><path d="M43.389 38.269L29.222 61.34a1.152 1.152 0 01-1.064.615H20.99a1.219 1.219 0 01-1.007-.5 1.324 1.324 0 01-.2-1.149L26.2 38.27H11.7l-3.947 6.919a1.209 1.209 0 01-1.092.644H1.285a1.234 1.234 0 01-.895-.392l-.057-.056a1.427 1.427 0 01-.308-1.036L1.789 32 .025 19.656a1.182 1.182 0 01.281-1.009 1.356 1.356 0 01.951-.448l5.4-.027a1.227 1.227 0 01.9.391.85.85 0 01.2.252L11.7 25.73h14.5L19.792 3.7a1.324 1.324 0 01.2-1.149A1.219 1.219 0 0121 2.045h7.168a1.152 1.152 0 011.064.615l14.162 23.071h8.959a17.287 17.287 0 017.839 1.791Q63.777 29.315 64 32q-.224 2.685-3.807 4.478a17.282 17.282 0 01-7.84 1.793h-9.016z"></path></svg>
        <div class="text-sm mx-2 flex flex-col">
          <p>Repülőjegy ár</p>
          <p class="font-bold text-xl">{{ flight.price }} Ft</p>
          <p class="text-xs text-gray-500">/fő</p>
        </div>
        <button @click="reserveTicket(flight)" v-if="!bookingCompleted" class="w-32 h-11 rounded flex border-solid border text-white bg-green-800 transition-all duration-150 ease-linear hover:bg-pink-600 mx-2 justify-center place-items-center"><div class="">Foglalj most!</div></button>
      </div>
    </div>
  </div>
</div>
    </div>
    <div v-if="bookingCompleted" class="min-h-screen bg-gray-100 flight-search">
  <div class="mx-auto px-6 py-12 bg-white border-0 shadow-lg sm:rounded-3xl">
    <h1 class="text-2xl font-bold mb-8">Rendelési információk</h1>
   <div v-for="(passenger, index) in passengerCount" :key="index"> 
   <h3 class="text-xl font-bold mb-8">{{ index + 1 }}. utas adatai:</h3>
	<div id="form" novalidate>
      <div class="relative z-0 w-full mb-5">
        <input
          type="text" placeholder=" "
          required
          class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200"
        />
        <label for="name" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Vezetéknév</label>
      </div>
	 <div>
	  
	  <div class="relative z-0 w-full mb-5">
        <input
          type="text" placeholder=" "
          required
          class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200"
        />
        <label for="name" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Keresztnév</label>
      </div>

      <div class="flex flex-row space-x-4">
        <div class="relative z-0 w-full mb-5">
          <input
            type="text"
            name="date"
            placeholder=" "
            onclick="this.setAttribute('type', 'date');"
            class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200"
          />
          <label for="date" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Dátum</label>
        </div>
      </div>
  </div>
</div>
</div>
      <h3 class="text-xl font-bold mb-8">Számlázási Adatok</h3>
      <div class="billing-info">

        <div class="relative z-0 w-full mb-5">
        <input
        type="text" id="billingName" placeholder=" "
          required
          class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200"
        />
        <label for="name" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Számlázási név</label>
      </div>

      <div class="relative z-0 w-full mb-5 border-0 border-b-2 appearance-none">
        <select class="pr-2 pt-2 pb-2" id="billingCountry">
            <option value="Hungary">Magyarország</option>
            <option value="Hungary">Románia</option>
            <option value="Hungary">Bulgária</option>
            <option value="Hungary">Csehország</option>
            <option value="Hungary">Ausztria</option>
          </select>
      </div>

      <div class="relative z-0 w-full mb-5">
        <input
        type="text" id="billingZip" placeholder=" "
          required
          class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200"
        />
        <label for="name" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Irányítószám</label>
      </div>

      <div class="relative z-0 w-full mb-5">
        <input
        type="text" id="billingCity" placeholder=" "
          required
          class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200"
        />
        <label for="name" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Város</label>
      </div>

      <div class="relative z-0 w-full mb-5">
        <input
        type="text" id="billingAddress" placeholder=" "
          required
          class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200"
        />
        <label for="name" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Lakcím</label>
      </div>
      </div>
      <h3 class="text-xl font-bold mt-6 mb-8">Fizetési mód</h3>
      <div class="payment-method">
        <h3 class="text-base"><input type="checkbox"> Bankkártyás fizetés</h3>
        <div class="payment-details">
          <p>A foglalás véglegesítésével egy biztonságos kártyaelfogadó oldalra irányítjuk, ahol a kártyaadatok megadásával egyszerűen kifizetheti repülőjegyét. Minden további teendőről és részletes információról, a fizetést követő visszaigazoló emailben tájékozódhat.</p>
          <p>Kérjük ne felejtse el megerősíteni fizetését mobileszközén! (3DS Authentication)</p>
          <br><p><b>Figyelem:</b> a sikeres fizetéssel a repülőjegy automatikusan kiállításra kerül és ezt követően már csak a légitársaság szabályainak megfelelően módosítható!</p>
        </div>
      </div>
      <h2 class="text-xl font-bold mt-6 mb-8">Ülőhely-választó</h2>
      <div>
        <p class="border-0 border-b-2 appearance-none">Foglalja le az Önnek megfelelő helyet a repülőgépen, így elkerülheti a légitársaság automatikus helyválasztását!</p>
        <button @click="toggleSeatSelector"
        class="w-50 px-6 py-3 mt-3 text-lg text-white transition-all duration-150 ease-linear rounded-lg shadow outline-none bg-pink-500 hover:bg-pink-600 hover:shadow-lg focus:outline-none">
      Ülőhely kiválasztás
      </button>
      </div>
      <div class="mt-4">
      <button @click="finalizeBooking" class="w-full mt-10 text-lg text-white transition-all duration-150 ease-linear rounded-lg shadow outline-none bg-pink-500 hover:bg-pink-600 hover:shadow-lg focus:outline-none">Véglegesítés</button>
    </div>
      <transition name="slide">
      <div v-if="showSeatSelector" class="seat-selector">
        <button class="close-btn" @click="toggleSeatSelector"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
</svg>
</button>
        <h2 class="text-xl font-bold mt-6 mb-8">Kérlek válassz széket:</h2>
        <div class="plane-seats">
          <div class="left-column">
            <div class="column" v-for="row in 2" :key="row">
              <div class="row" v-for="column in 2" :key="column">
                <div class="seat"
                    :class="{ 'unavailable': isSeatBooked(row, seatNumber, column), 'selected': isSelectedSeat(row, seatNumber, column) }"
                    v-for="seatNumber in 30"
                    :key="(row - 1) * 30 + seatNumber"
                    @click="selectSeat(row, seatNumber, column)">
                  {{ getSeatLabel(row, seatNumber, column) }}
                </div>
              </div>
            </div>
          </div>
          <div class="empty-column"></div>
          <div class="right-column">
            <div class="column" v-for="row in 2" :key="row">
              <div class="row" v-for="column in 2" :key="column">
                <div class="seat"
                    :class="{ 'unavailable': isSeatBooked(row, seatNumber, 3 + column), 'selected': isSelectedSeat(row, seatNumber, 3 + column) }"
                    v-for="seatNumber in 30"
                    :key="(3 + column - 1)  * 30 + seatNumber"
                    @click="selectSeat(row, seatNumber, 3 + column)">
                  {{ getSeatLabel(row, seatNumber, 3 + column) }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>    
   </div>
  </div>
</div>

  <div class="flight-search" v-if="!bookingCompleted">
    <h1 class="font-bold text-center text-4xl text-gray-600">Nem tudod hova utazz?</h1>
  <iframe style="margin:10%" width="75%" height="50%" frameborder="0" scrolling="yes" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?width=100%25&amp;height=1300&amp;hl=en&amp;q=Vasv%C3%A1ri+(Utazz%20b%C3%A1rhov%C3%A1)&amp;t=&amp;z=4&amp;ie=UTF8&amp;iwloc=B&amp;output=embed"><a href="https://www.gps.ie/">gps systems</a></iframe>
  </div>

    <h1 class="font-bold text-center text-4xl pt-10 text-gray-600">Repülőtársaságok akikkel együtt dolgozunk</h1>
                <div class="mx-auto max-w-7xl m-12 px-6 sm:mt-16 lg:px-8">
                         <div x-data="{}" x-init="$nextTick(() => {
                             let ul = $refs.logos;
                             ul.insertAdjacentHTML('afterend', ul.outerHTML);
                             ul.nextSibling.setAttribute('aria-hidden', 'true');
                         })" class="w-full inline-flex flex-nowrap overflow-hidden [mask-image:_linear-gradient(to_right,transparent_0,_black_128px,_black_calc(100%-128px),transparent_100%)]">
                         <ul x-ref="logos" class="grayscale flex items-center justify-center md:justify-start [&amp;_li]:mx-8 [&amp;_img]:max-w-[150px] animate-infinite-scroll">
                             <li>
                                 <img src="../../assets/Images/luft.png" alt="Facebook">
                             </li>
                             <li>
                                 <img src="../../assets/Images/airbaltic.png" alt="Disney">
                             </li>
                             <li>
                                <img src="../../assets/Images/korean.png" alt="Samsung">
                            </li>
                             <li>
                                 <img src="../../assets/Images/turkish.png" alt="Spark">
                             </li>
                         </ul><ul x-ref="logos" class="grayscale flex items-center justify-center md:justify-start [&amp;_li]:mx-8 [&amp;_img]:max-w-[150px] animate-infinite-scroll" aria-hidden="true">
                             <li>
                                 <img src="../../assets/Images/luft.png" alt="Facebook">
                             </li>
                             <li>
                                 <img src="../../assets/Images/luft.png" alt="Disney">
                             </li>
                             <li>
                                <img src="../../assets/Images/luft.png" alt="Samsung">
                            </li>
                             <li>
                                 <img src="../../assets/Images/luft.png" alt="Spark">
                             </li>
                         </ul>                
                     </div>
     
                 </div>
</template>

<script setup>
import axios from 'axios';
import { ref, onMounted } from 'vue';
import { parseToken, getUsername } from '../../utils/auth.js';
import { useRouter } from 'vue-router';
import Toastify from 'toastify-js';
import 'toastify-js/src/toastify.css';
const router = useRouter();


const showToast = () => {
  Toastify({
    text: "Hiányzó keresési adatok!",
    duration: 3000,
    gravity: "top",
    position: 'center',
    backgroundColor: "#e80c2d"
  }).showToast();
};

const showToast2 = () => {
  Toastify({
    text: "Maximum hely kiválasztva!",
    duration: 3000,
    gravity: "top",
    position: 'center',
    backgroundColor: "#e80c2d"
  }).showToast();
};

const showToast3 = () => {
  Toastify({
    text: "Válassz ki ülőhelyet!",
    duration: 3000,
    gravity: "top",
    position: 'center',
    backgroundColor: "#e80c2d"
  }).showToast();
};



const token = localStorage.getItem('token');
const payload = parseToken(token);
const user = getUsername(payload);

const from = ref('');
const to = ref('');
const departureTime = ref('');
const passengerCount = ref('');
const flightClass = ref('');
const countries = ref([]);
const searchResults = ref([]);
const bookingCompleted = ref(false);
const showSeatSelector = ref(false);
const bookedSeats = ref([]);

const toggleSeatSelector = () => {
  showSeatSelector.value = !showSeatSelector.value;
};

onMounted(async() => {
  axios.get('https://localhost:7151/api/Orszagok')
    .then(resp => {
      countries.value = resp.data;
    })
    .catch(error => {
      console.error('Error fetching countries:', error);
    });
    try {
       const response = await axios.get('https://localhost:7151/api/Jegykezeles');
        response.data.forEach(seat => {
          if (seat.sorSzek.includes(';')) {
            const seats = seat.sorSzek.split(';').map(part => part.split(',').map(val => parseInt(val.trim())));
            seats.forEach(seatArray => bookedSeats.value.push(seatArray));
          } else {
            const singleSeat = seat.sorSzek.split(',').map(part => parseInt(part.trim()));
            bookedSeats.value.push(singleSeat);
          }
        });
    } catch (error) {
      console.error('Hiba a foglalt székek lekérdezésekor:', error);
    }

});

const generateRandomPrice = () => {
  return Math.floor(Math.random() * 10000) + 15000;
};

const generateRandomTwoNumber = () => {
  return Math.floor(Math.random() * 9) + 2;
};


const searchFlights = async () => {
  try {
    const seged = ref([]);
    const response = await axios.get(`https://localhost:7151/api/JegyAdatok/search`, {
      params: {
          honnan: from.value,
          hova: to.value
      },
    });
    seged.value = response.data;
    if (!response.data || response.data.length === 0) {
      console.log('Nincs ilyen járat.');
      return;
    } else {
      let prevId = 0; 
      const flights = response.data.map(flight => {
        const id = prevId + 1; 
        prevId = id; 
        return {
          id,
          user : user,
          from: from.value,
          to: to.value,
          departure: `${seged.value[id-1].ora}:${seged.value[id-1].perc}` ,
          arrival: `${(seged.value[id-1].ora)+2}:${seged.value[id-1].perc}`,
          class : flightClass.value,
          passenger : passengerCount.value,
          price: generateRandomPrice()
        };
      });
      searchResults.value = flights;
    }
  } catch (error) {
    console.error('Hiba az adatok lekérdezésében:', error);
    showToast();
  }
};

const reserveTicket = async (flight) => {
  try {
    searchResults.value = [];
    searchResults.value.push(flight);
    bookingCompleted.value = true;
  } catch (error) {
    console.error('Hiba a jegy foglalásában:', error);
  }
};

const selectedSeats = ref([]);
const selectedSeatsData = ref([]);

const selectSeat = (row, seatNumber, column) => {
  const seatIndex = (row - 1) * 30 + (column - 1) * 30 + seatNumber;
  const isBooked = isSeatBooked(row, seatNumber, column);
  
  if (selectedSeats.value.includes(seatIndex)) {
    const index = selectedSeats.value.indexOf(seatIndex);
    if (index > -1) {
      selectedSeats.value.splice(index, 1);
      const seatData = `${row}, ${seatNumber}, ${column}`;
      selectedSeatsData.value = selectedSeatsData.value.split(';').filter(item => item !== seatData).join(';');      
    }
    return; 
  }

  if (selectedSeats.value.length < passengerCount.value) {
    if (!isBooked) {
      if (!selectedSeats.value.includes(seatIndex)) {
        selectedSeats.value.push(seatIndex);
        if (selectedSeatsData.value != 0) {
            selectedSeatsData.value += `;${row}, ${seatNumber}, ${column}`
        } else {
          selectedSeatsData.value += `${row}, ${seatNumber}, ${column}`
        }
      }
    }
  } else {
    console.log('Maximum seat count reached.');
    showToast2();
  }
};

const getSeatLabel = (row, seatNumber, column) => {
  const seatIndex = (row - 1) * 30 + (column - 1) * 30 + seatNumber;
  const isBooked = isSeatBooked(row, seatNumber, column);
  if (isBooked) {
    return 'X';
  } else {
    return `${seatIndex}`;
  }
};

const finalizeBooking = async () => {
  try {

    if (searchResults.value.length === 0) {
      console.error('Nincs kiválasztott repülőjegy.');
      return;
    }
    const selectedFlight = searchResults.value[0];
    console.log(selectedSeatsData.value)

    const segedar = selectedFlight.price * selectedFlight.passenger

    const response = await axios.post('https://localhost:7151/api/Jegykezeles', {
      'megrendelo_nev': selectedFlight.user,
      'Indulas_hely': selectedFlight.from,
      'erkezes_hely': selectedFlight.to ,
      'indulasido': selectedFlight.departure,
      'utazok' : selectedFlight.passenger,
      'osztaly' : selectedFlight.class,
      'ar': segedar,
      'erkezesido': selectedFlight.arrival,
      'SorSzek' : selectedSeatsData.value
    });


    console.log('Booking successful:', response.data);
    router.push("/")

  } catch (error) {
    console.error('Error finalizing booking:', error);
    showToast3();
  }
};

const isSeatBooked = (row, seatNumber, column) => {
  const seat = `${row}, ${seatNumber}, ${column}`;
  for (let index = 0; index < bookedSeats.value.length; index++) {
    if (bookedSeats.value[index][0] == row && bookedSeats.value[index][1] == seatNumber && bookedSeats.value[index][2] == column ) {
      return true
    }
  }
};


const isSelectedSeat = (row, seatNumber, column) => {
  const seatIndex = (row - 1) * 30 + (column - 1) * 30 + seatNumber;
  return selectedSeats.value.includes(seatIndex);
};

</script>

<style scoped>
.flight-search {
  max-width: 75%;
  margin: 0 auto;
  margin-top:50px;
}

.search-fields {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.field label {
  font-weight: bold;
}

.field input, .field select {
  width: 100%;
  padding: 8px;
  border-radius: 5px;
  border: 1px solid #ccc;
}

button {
  margin-top: 10px;
  padding: 8px 16px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.search-results {
  margin-top: 20px;
}

.flight-card {
  display: flex;
  margin-bottom: 10px;
  padding: 10px;
  border: 1px solid #ccc;
}

.flight-card .left, .flight-card .right {
  flex: 1;
}

.flight-card .right {
  text-align: right;
}
.payment-method {
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 10px;
  margin-top: 20px;
}

.payment-method h3 {
  font-size: 24px;
  margin-bottom: 10px;
}

.payment-content p {
  font-size: 14px;
  line-height: 1.5;
  margin-bottom: 10px;
}
.slide-enter-active, .slide-leave-active {
  transition: transform 0.5s ease;
}
.slide-enter, .slide-leave-to {
  transform: translateX(0);
}
.slide-enter-to, .slide-leave {
  transform: translateX(100%);
}

.seat-selector {
  position: fixed;
  top: 0;
  right: 0;
  width: 400px;
  height: 90%;
  background-color: #f0e9e9;
  box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);
  z-index: 1000; 
  padding: 40px;
  overflow-y: auto;
}

.close-btn {
  position: absolute;
  top: 10px;
  right: 10px;
  padding: 5px 10px;
  background-color: #1a222b;
  cursor: pointer;
}

.plane-seats {
  display: flex;
}

.left-column,
.right-column {
  flex: 1;
}

.empty-column {
  width: 40px;
}

.column {
  display: flex;
  flex-direction: column;
}

.row {
  display: flex;
  flex-wrap: wrap;
}

.seat {
  width: 40px;
  height: 40px;
  margin: 5px;
  border: 1px solid #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
}
.unavailable {
  background-color: #ccc; 
  pointer-events: none; 
}
.selected {
  background-color: rgb(76, 78, 76);
  color: white;
}

.-z-1 {
    z-index: -1;
  }

  .origin-0 {
    transform-origin: 0%;
  }

  input:focus ~ label,
  input:not(:placeholder-shown) ~ label,
  textarea:focus ~ label,
  textarea:not(:placeholder-shown) ~ label,
  select:focus ~ label,
  select:not([value='']):valid ~ label {
    /* @apply transform; scale-75; -translate-y-6; */
    --tw-translate-x: 0;
    --tw-translate-y: 0;
    --tw-rotate: 0;
    --tw-skew-x: 0;
    --tw-skew-y: 0;
    transform: translateX(var(--tw-translate-x)) translateY(var(--tw-translate-y)) rotate(var(--tw-rotate))
      skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
    --tw-scale-x: 0.75;
    --tw-scale-y: 0.75;
    --tw-translate-y: -1.5rem;
  }

  input:focus ~ label,
  select:focus ~ label {
    /* @apply text-black; left-0; */
    --tw-text-opacity: 1;
    color: rgba(0, 0, 0, var(--tw-text-opacity));
    left: 0px;
  }
</style>
