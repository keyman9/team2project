function showDiv(id) {
    document.getElementById(id).style.display = "block";
}

function showContent(toShow) {
    var aeropress = document.getElementById("aero");
    var frenchPress = document.getElementById("french");
    var mokaPot = document.getElementById("moka");
    var chemex = document.getElementById("chemex");

    if(toShow == 'brew') {
        document.getElementById("brew").style.visibility = 'visible';
        document.getElementById("beans").style.visibility= 'hidden';

        document.getElementById("brew").style.display= 'block';
        document.getElementById("beans").style.display= 'none';

        /* change the color of the active button */
        document.getElementById("tech").style.background= '#241109';
        document.getElementById("tech").style.color= '#c8b69d';

        document.getElementById("bean-and-roast").style.background= '#faf4ec';
        document.getElementById("bean-and-roast").style.color= '#241109';


    } else if(toShow == 'beans') {
        document.getElementById("brew").style.visibility = 'hidden';
        document.getElementById("beans").style.visibility = 'visible';

        document.getElementById("brew").style.display= 'none';
        document.getElementById("beans").style.display= 'block';

        /* change the colors of the buttons after being clicked */
        document.getElementById("bean-and-roast").style.background= '#241109';
        document.getElementById("bean-and-roast").style.color= '#c8b69d';

        document.getElementById("tech").style.background= '#faf4ec';
        document.getElementById("tech").style.color= '#241109';
    } else if(toShow == 'aero') {
        aeropress.style.visibility = 'visible';
        frenchPress.style.visibility = 'hidden';
        mokaPot.style.visibility = 'hidden';
        chemex.style.visibility = 'hidden';

        aeropress.style.display = 'block';
        frenchPress.style.display = 'none';
        mokaPot.style.display = 'none';
        chemex.style.display = 'none';

    } else if(toShow == 'french') {
        aeropress.style.visibility = 'hidden';
        frenchPress.style.visibility = 'visible';
        mokaPot.style.visibility = 'hidden';
        chemex.style.visibility = 'hidden';

        aeropress.style.display = 'none';
        frenchPress.style.display = 'block';
        mokaPot.style.display = 'none';
        chemex.style.display = 'none';

    } else if(toShow == 'moka') {
        aeropress.style.visibility = 'hidden';
        frenchPress.style.visibility = 'hidden';
        mokaPot.style.visibility = 'visible';
        chemex.style.visibility = 'hidden';

        aeropress.style.display = 'none';
        frenchPress.style.display = 'none';
        mokaPot.style.display = 'block';
        chemex.style.display = 'none';

    } else if(toShow == 'chemex') {
        aeropress.style.visibility = 'hidden';
        frenchPress.style.visibility = 'hidden';
        mokaPot.style.visibility = 'hidden';
        chemex.style.visibility = 'visible';

        aeropress.style.display = 'none';
        frenchPress.style.display = 'none';
        mokaPot.style.display = 'none';
        chemex.style.display = 'block';

    }
}
