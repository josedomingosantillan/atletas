window.onload = function () {
    pantalla = document.getElementById("screen");
}

var isMarch = false;
var acumularTime = 0;

function start() {
    if (isMarch == false) {
        timeInicial = new Date();
        control = setInterval(cronometro, 10);
        isMarch = true;
    }
}

function cronometro() {
    timeActual = new Date();
    acumularTime = timeActual - timeInicial;
    acumularTime2 = new Date();
    acumularTime2.setTime(acumularTime);
    cc = Math.round(acumularTime2.getMilliseconds() / 10);
    ss = acumularTime2.getSeconds();
    mm = acumularTime2.getMinutes();
    hh = acumularTime2.getHours() - 18;
    if (cc < 10) {
        cc = "0" + cc;
    }
    if (ss < 10) {
        ss = "0" + ss;
    }
    if (mm < 10) {
        mm = "0" + mm;
    }
    if (hh < 10) {
        hh = "0" + hh;
    }
    pantalla.innerHTML = hh + " : " + mm + " : " + ss + " : " + cc;
}

function stop() {
    if (isMarch == true) {
        clearInterval(control);
        isMarch = false;
    }
}


function reset() {
    if (isMarch == true) {
        clearInterval(control);
        isMarch = false;
    }
    acumularTime = 0;
    pantalla.innerHTML = "00 : 00 : 00 : 00";
}

let valor = '', comienzo = '', termino = '';
$(document).on("click", "#btnrt", function (e) {
    start();
    comienzo = moment();
});
$(document).on("click", "#one_lap", function (e) {
    stop();
    termino = moment();
    valor = document.getElementById('screen').innerText;
    lapone.value = valor
    hab_des(this, two_lap);
    peticion(valor, 1, comienzo, termino)
    start();
    comienzo = moment();
});
$(document).on("click", "#two_lap", function (e) {
    stop();
    termino = moment();
    valor = document.getElementById('screen').innerText;
    laptwo.value = valor
    hab_des(this, three_lap);
    peticion(valor, 2, comienzo, termino)
    start();
    comienzo = moment();
});
$(document).on("click", "#three_lap", function (e) {
    stop();
    termino = moment();
    valor = document.getElementById('screen').innerText;
    lapthree.value = valor
    hab_des(this, one_lap);
    peticion(valor, 3, comienzo, termino)
});

const hab_des = (desa, habil) => {
    desa.setAttribute('style', "float: right; display: none")
    habil.setAttribute('style', "float: right; display: block")
}


const peticion = (valor, vuelta, comienzo, termino) => {
    total = comienzo.diff(moment.duration(termino), 'seconds,miliseconds');

    let id = id_usuario = select_runs.options[select_runs.selectedIndex].value;
    if (parseInt(id) != 0) {
        $.ajax({
            type: "POST",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            url: "runnings/update_lap",
            data: {
                Id_usuario: id,
                tiempo: valor,
                num_vuelta: vuelta,
                total: total
            }
        });
    }
}
