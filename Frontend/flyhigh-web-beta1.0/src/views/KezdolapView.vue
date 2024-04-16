<template>
  <div class="relative flex flex-col-reverse py-16 lg:pt-0 lg:flex-col lg:pb-0">
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
        <h2 data-aos="fade-right" class="mb-5 font-sans text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl sm:leading-none">
          Minden út egy kaland <br class="hidden md:block" /> -
          hadd legyünk a vezetőid!
        </h2>
        <p class="pr-5 mb-5 text-base text-gray-700 md:text-lg">
          2023 óta a piacon, azért hogy ügyfeleink kényelmesen foglaljanak repülőjegyet kedvenc úticélukhoz.
        </p>
        <div class="flex items-center">
          <a
          href="/jegyadatok"
            class="bg-blue-600 cursor-pointer text-white inline-flex items-center h-12 px-6 mr-6 font-medium tracking-wide  rounded shadow-md"
          >
            Jegyvásárlás
        </a>
          <a target="_blank" href="https://booking.com" aria-label="" class="inline-flex items-center font-semibold">Hotelek</a>
        </div>
      </div>
    </div>
  </div>
  <div class="flight-search">
    <h1 class="font-bold text-center text-4xl text-gray-600 mt-16">Nem tudod hova utazz?</h1>
  <iframe style="margin:10%" width="75%" height="50%" frameborder="0" scrolling="yes" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?width=100%25&amp;height=1300&amp;hl=en&amp;q=Vasv%C3%A1ri+(Utazz%20b%C3%A1rhov%C3%A1)&amp;t=&amp;z=4&amp;ie=UTF8&amp;iwloc=B&amp;output=embed"><a href="https://www.gps.ie/">gps systems</a></iframe>
  </div>

    <h1 class="font-bold text-center text-4xl pt-10 text-gray-600">Repülőtársaságok akikkel együtt dolgozunk</h1>
                <div class="mx-auto max-w-7xl m-12 px-6 sm:mt-16 lg:px-8">
                         <div x-data="{}" x-init="$nextTick(() => {
                             let ul = $refs.logos;
                             ul.insertAdjacentHTML('afterend', ul.outerHTML);
                             ul.nextSibling.setAttribute('aria-hidden', 'true');
                         })" class="w-full inline-flex flex-nowrap overflow-hidden [mask-image:_linear-gradient(to_right,transparent_0,_black_128px,_black_calc(100%-128px),transparent_100%)]">
                         <ul x-ref="logos" class="grayscale flex  items-center justify-center md:justify-start [&amp;_li]:mx-8 [&amp;_img]:max-w-[150px] animate-infinite-scroll">
                             <li>
                                 <img src="../../assets/Images/luft.png" alt="luft">
                             </li>
                             <li>
                                 <img src="../../assets/Images/airbaltic.png" alt="airbaltic">
                             </li>
                             <li>
                                <img  src="../../assets/Images/korean.png" alt="korean">
                            </li>
                             <li>
                                 <img src="../../assets/Images/turkish.png" alt="turkish">
                             </li>
                             <li>
                                 <img class="w-24" src="../../assets/Images/alitalia.png" alt="alitalia">
                             </li>
                             <li>
                                 <img class="w-24" src="../../assets/Images/dutch.png" alt="dutch">
                             </li>
                             <li>
                                <img class="w-24" src="../../assets/Images/americanairlines.png" alt="americanairlines">
                            </li>
                             <li>
                                 <img class="w-24" src="../../assets/Images/wizzair.png" alt="wizzair">
                             </li>
                         </ul>                
                     </div>
                 </div>
</template>