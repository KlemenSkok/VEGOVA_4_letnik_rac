
let imageNumber = 1;
let asc = true;
let imageInterval = 100;


function displayImage() {
    document.getElementById("slika").src = '../images/slike 2/atlet' + imageNumber + '.gif';
    if(asc) {
        imageNumber++;
    }
    else imageNumber--;

    if(imageNumber < 1) {
        imageNumber = 1;
        asc = true;
    }
    if(imageNumber > 5) {
        asc = false;
        imageNumber = 5;
    }
}

let displayTimer = window.setInterval(displayImage, imageInterval);

document.getElementById("slow-anim").addEventListener("click", () => {
    clearInterval(displayTimer);
    imageInterval += 10;
    displayTimer = setInterval(displayImage, imageInterval);
});

document.getElementById("fast-anim").addEventListener("click", () =>{
    clearInterval(displayTimer);
    imageInterval -= 10;
    if(imageInterval < 10)
        imageInterval = 10;
    displayTimer = setInterval(displayImage, imageInterval);
});