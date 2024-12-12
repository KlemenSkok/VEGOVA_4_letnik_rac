
async function getFilmi() {
    (await fetch("filmi.json")
    .then((data) => {
        return data.json();
    }))
}