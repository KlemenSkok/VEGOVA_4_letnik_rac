
function prikaziIme() {
    const ime = document.getElementById("input_ime").value;
    if(ime === "") {
        return;
    }
    document.getElementById("pozdrav").innerHTML = "Pozdravljen " + ime + "!";
    document.getElementById("vnos-imena").style.display = "none";
}

function skrajsaj_odstavek() {
    let odstavek = document.getElementById("odstavek").innerHTML;
    document.getElementById("odstavek").innerHTML = odstavek.substring(0, 160);
}

function dolzina_odstavka() {
    let dolzina = document.getElementById("odstavek").innerHTML.length;
    document.getElementById("izpis_dolzina_odstavka").innerHTML = "Zgornji izpis je dolg " + dolzina + " znakov.";
    document.getElementById("odstavek").style.color = ""
}

function obrni_besedilo() {
    document.getElementById("odstavek").innerHTML = document.getElementById("odstavek").innerHTML.split("").reverse().join("");
}

function zamenjaj_sumnike() {
    let besedilo = document.getElementById("odstavek").innerHTML;
    besedilo = besedilo.replace(/č/g, "c");
    besedilo = besedilo.replace(/Č/g, "C");
    besedilo = besedilo.replace(/š/g, "s");
    besedilo = besedilo.replace(/Š/g, "S");
    besedilo = besedilo.replace(/ž/g, "z");
    besedilo = besedilo.replace(/Ž/g, "Z");
    document.getElementById("odstavek").innerHTML = besedilo;
}

function je_prestopno(leto) {
    if ((leto % 4 == 0) && (leto % 100 != 0) || (leto % 400 == 0)) {
        return true;
    }
    return false;
}

function preveri_leto() {
    if(je_prestopno(document.getElementById("leto").innerHTML)) {
        document.getElementById("leto-je-prestopno").innerHTML = "Leto je prestopno.";
    }
    else {
        document.getElementById("leto-je-prestopno").innerHTML = "Leto ni prestopno.";
    }
}


document.getElementById("leto").innerHTML = Math.floor(Math.random() * 10000);
preveri_leto();