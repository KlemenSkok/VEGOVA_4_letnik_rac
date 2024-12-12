let clan_counter = 0;

function dodajClana() {

    let form = document.getElementById("form");
    let clan = `
    <pre class="form-clan">
        <u><font size="+1">član:</font></u>
        
        <b>Ime:</b>  <input type="text" name="ime_c${clan_counter}" size="20">
        <b>Priimek:</b>  <input type="text" name="priimek_c${clan_counter}" size="20">
        <b>E-pošta:</b>  <input type="text" name="eposta_c${clan_counter}" size="20">
        <b>Fakulteta oz. podjetje:</b>  <input type="text" name="faks_c${clan_counter}" size="20">
        <b>Letnik študija (če ste študent ali dijak):</b>  <input type="text" name="letnik_c${clan_counter}" size="20">
    </pre>`;
    form.removeChild(form.lastElementChild);
    
    form.innerHTML += clan;
    form.innerHTML += `<button type="submit">Pošlji obrazec</button>`;
    
    clan_counter++;
}

function odstraniClana() {
    if(clan_counter <= 0)   
        return;
    
    let form = document.getElementById("form");
    form.removeChild(form.lastElementChild);
    form.removeChild(form.lastElementChild);
    
    form.innerHTML += `<button type="submit">Pošlji obrazec</button>`;

    clan_counter--;
}


/* 

<pre class="form-clan">
    <u><font size="+1">član:</font></u>
    
    <b>Ime:</b>  <input type="text" name="ime_c1" size="20">
    <b>Priimek:</b>  <input type="text" name="priimek_c1" size="20">
    <b>E-pošta:</b>  <input type="text" name="eposta_c1" size="20">
    <b>Fakulteta oz. podjetje:</b>  <input type="text" name="faks_c1" size="20">
    <b>Letnik študija (če ste študent ali dijak):</b>  <input type="text" name="letnik_c1" size="20">
</pre>

<pre class="form-clan">
    <u><font size="+1">član:</font></u>
    
    <b>Ime:</b>  <input type="text" name="ime_c2" size="20">
    <b>Priimek:</b>  <input type="text" name="priimek_c2" size="20">
    <b>E-pošta:</b>  <input type="text" name="eposta_c2" size="20">
    <b>Fakulteta oz. podjetje:</b>  <input type="text" name="faks_c2" size="20">
    <b>Letnik študija (če ste študent ali dijak):</b>  <input type="text" name="letnik_c2" size="20">
</pre>

*/