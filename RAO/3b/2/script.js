const steviloSlik = 5;
let stevec_slik = 1;


function menjajSliko() {
    document.getElementById("slika").src = '../images/slike 2/album' + stevec_slik + '.jpg';
}

document.getElementById("nazaj").addEventListener("click", () => {
    stevec_slik--;
    if(stevec_slik < 1)
        stevec_slik = steviloSlik;
    menjajSliko();
});

document.getElementById("naprej").addEventListener("click", () => {
    stevec_slik++;
    if(stevec_slik > steviloSlik)
    stevec_slik = 1;
    menjajSliko();
});

document.getElementById("prva").addEventListener("click", () => {
    stevec_slik = 1;
    menjajSliko();
});

document.getElementById("zadnja").addEventListener("click", () => {
    stevec_slik = steviloSlik;
    menjajSliko();
});


menjajSliko();