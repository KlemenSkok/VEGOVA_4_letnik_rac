
let recept = {
    naslov: "ljubljanski zrezek", 
    porcije: 4, 
    sestavine: ["puranji file", "sir", "šunka", "moka", "jajca", "krušne drobtine", "sol"]
};

function setNaslov(n) {
    document.getElementById("naslov-recepta").innerHTML = n;
}

function setPorcije(p) {
    document.getElementById("st-porcij").innerHTML = p;
}

function fillSestavine(sestavine) {
    let tab = document.getElementById("recept");
    

    for(let i = 0; i < sestavine.length; i++) {
        let el_tr = document.createElement("tr");
        let el_td = document.createElement("td");
        el_td.setAttribute("class", "sestavina");
        el_td.innerHTML = sestavine[i];
        
        el_tr.appendChild(el_td);
        tab.appendChild(el_tr);
    }
}

document.getElementById("naslov-recepta").addEventListener("click", () => {
    alert("To je moj najljubši recept!");
});



setNaslov(recept.naslov);
setPorcije(recept.porcije);
fillSestavine(recept.sestavine);

const cells = document.querySelectorAll('td.sestavina');
cells.forEach(cell => {

    cell.addEventListener('mouseenter', function() {
        //this.style.backgroundColor = 'rgb(' + floor(Math.random() * 255) + ', ' + floor(Math.random() * 255) + ', ' + floor(Math.random() * 255) + ')';
        this.style.backgroundColor = `rgb(${Math.random() * 255}, ${Math.random() * 255}, ${Math.random() * 255})`;
    });
    
    cell.addEventListener('mouseleave', function() {
        this.style.backgroundColor = '';
    });
});