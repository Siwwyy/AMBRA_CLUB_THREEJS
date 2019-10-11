<!doctype html>
<html lang="UTF-8">
<head>
  <title>Hello World (Three.js)</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
  <link rel=stylesheet href="base.css"/>
</head>
<body>

<script src="Three.js"></script>
<script src="Detector.js"></script>
<script src="Stats.js"></script>
<script src="OrbitControls.js"></script>
<script src="THREEx.KeyboardState.js"></script>
<script src="THREEx.FullScreen.js"></script>
<script src="THREEx.WindowResize.js"></script>

<!-- jQuery code to display an information button and box when clicked. -->

<!-- ------------------------------------------------------------ -->
<!--<iframe width="100%" height="100" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/530888031&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"></iframe>-->
<div id="ThreeJS" style="z-index: 1; position: absolute; left:0px; top:0px"></div>
<div id="info">AMBRA CLUB</div>
<div id="controls">Turn on all lights-> a or A<br>
Turn on all extra white lights-> z or Z<br>
Turn off all extra white lights->x or X<br>
Turn off red light-> r or R <br>
Turn off white center light-> w or W <br>
Turn off blue light-> b or B <br>
Turn off yellow light-> y or Y <br>
 </div>
<script>
  
//////////  
// MAIN //
//////////
// standard global variables
var container, scene, camera, controls, sphere, sun, textureCube, loader, stats, cubeCamera, renderer;
//lights
var spotlight1, spotlight2, targetObject, light2, light3, light4, light5, light6, light7;

var light_special1, light_special2, light_special3, light_special4;
var cube_special1, cube_special2, cube_special3;

/*var audio = new Audio();
      audio.src = 'MERCUS.mp3';
      audio.controls = true;
      audio.loop = true;
      audio.autoplay = true;
      // Establish all variables that your Analyser will use
      var  ctx, source, context, analyser, fbc_array, bars, bar_x, bar_width, bar_height;
      // Initialize the MP3 player after the page loads all of its HTML into the window*/




document.addEventListener("keydown", onDocumentKeyDown, false);
init();
draw();
draw_skybox();
/*initMp3Player();
frameLooper();*/
animate();
create_lights();
//update(var t, var d);

function init() {
  //set up scene
  scene = new THREE.Scene();
  scene.fog = new THREE.FogExp2(0x000000, .0007);

  var width = window.innerWidth;
  var height = window.innerHeight;

  renderer = new THREE.WebGLRenderer({
    antialias: true
  });

  renderer.setSize(width, height);
  renderer.setClearColor(0x000011, 1);
  renderer.domElement.id = "context";
  document.body.appendChild(renderer.domElement);
  container = document.getElementById( 'ThreeJS' );
  container.appendChild( renderer.domElement );

  //set up camera
  camera = new THREE.PerspectiveCamera(45, width / height, .1, 10000);
  scene.add(camera);
  camera.position.set(0, 150, -630);
  camera.lookAt(scene.position);

  //set up stats frame
  stats = new Stats();
  stats.domElement.style.position = 'absolute';
  stats.domElement.style.bottom = '0px';
  stats.domElement.style.zIndex = 100;
  container.appendChild( stats.domElement );

  //set up a floor
  var floorTexture = new THREE.TextureLoader().load( 'checkerboard.jpg' );
  floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping; 
  floorTexture.repeat.set( 10, 10 );
  // DoubleSide: render texture on both sides of mesh
  var floorMaterial = new THREE.MeshPhongMaterial( { map: floorTexture, side: THREE.DoubleSide } );
  var floorGeometry = new THREE.PlaneGeometry(1500, 1500, 1, 1);
  var floor = new THREE.Mesh(floorGeometry, floorMaterial);
  floor.position.y = -0.5;
  floor.rotation.x = Math.PI / 2;
  floor.receiveShadow  = true;
  scene.add(floor);

    //set logo
  var logoTexture = new THREE.TextureLoader().load( 'ambra.jpg' );
    //logoTexture.wrapS = logoTexture.wrapT = THREE.RepeatWrapping; 
  // DoubleSide: render texture on both sides of mesh
  var logoMaterial = new THREE.MeshPhongMaterial( { map: logoTexture } );
  var geometryLogo = new THREE.BoxGeometry( 400, 100, 8 );
  var logo = new THREE.Mesh(geometryLogo, logoMaterial);
  logo.position.y = 200;
   logo.position.z = 50;
    logo.position.x = 300;
  //logo.rotation.x = Math.PI / 2;
  //logo.receiveShadow  = true;
  scene.add(logo);


  //set up cube camera
  cubeCamera = new THREE.CubeCamera(1, 100000, 1024);
  scene.add(cubeCamera);


  //set up fill lights
  var ambientLight = new THREE.AmbientLight(0x4d4d4d);
  ambientLight.castShadow = true;
  scene.add(ambientLight);

  var axes = new THREE.AxisHelper(100);
  scene.add( axes );

  //set up color lights

     var intensity = 20;
      var distance = 200;
      var decay = 2.0;

     /* var c1 = 0xff0040,
        c2 = 0x0040ff,
        c3 = 0x80ff80,
        c4 = 0xffaa00,
        c5 = 0x00ffaa,
        c6 = 0xff1100;*/
      var color1 = 0x0000ff, //blue
      color2 = 0xff66cc, //pink troche
      color3 = 0x00ff00, //limonkowy
      color4 = 0xffff00, //zolty
      color5 = 0x00ffff, //aqua blue
      color6 = 0xff0000; //red
      color7 = 0xffffff; //white

  light2 = new THREE.PointLight(color1, intensity, distance, decay);
  light2.position.set(0,160,0);
 /* light2.add(new THREE.Mesh(dot, new THREE.MeshPhongMaterial({
    color: c1
  })));*/
 scene.add(light2);

   light3 = new THREE.PointLight(color6, intensity, distance, decay);
  light3.position.set(0,160,0);
  /*light3.add(new THREE.Mesh(dot, new THREE.MeshPhongMaterial({
    color: c2
  })));*/
scene.add(light3);

  light4 = new THREE.PointLight(color5, intensity, distance, decay);
  light4.position.set(0,160,0);
 /* light4.add(new THREE.Mesh(dot, new THREE.MeshPhongMaterial({
    color: c3
  })));*/
 scene.add(light4);

  light5 = new THREE.PointLight(color3, intensity, distance, decay);
  light5.position.set(0,160,0);
 /* light5.add(new THREE.Mesh(dot, new THREE.MeshPhongMaterial({
    color: c4
  })));*/
  scene.add(light5);

  light6 = new THREE.PointLight(color4, intensity, distance, decay);
  light6.position.set(0,160,0);
  /*light6.add(new THREE.Mesh(dot, new THREE.MeshPhongMaterial({
    color: c5
  })));*/
  scene.add(light6);

 light7 = new THREE.PointLight(color2, intensity, distance, decay);
 light7.position.set(0,160,0);
/*  light7.add(new THREE.Mesh(dot, new THREE.MeshPhongMaterial({
    color: c6
  })));*/
   light8 = new THREE.PointLight(color7, intensity, distance, decay);
 light8.position.set(10,130,160);
 // light8.position.set(0,160,0);
  //scene.add(light8);


  /*
    SPECIAL 4 LIGHTS WHITE (currently 3 lights)
  */

   
  var geometry = new THREE.BoxGeometry( 20, 30, 20 );
  var material = new THREE.MeshPhongMaterial( {color: color7, shininess: 40,reflectivity: 6} );
    cube_special1 = new THREE.Mesh( geometry, material );
  cube_special1.position.set(250,200,50);
  //scene.add( cube_special1 );


  light_special1 = new THREE.PointLight(color7, 25, 150, decay);
  light_special1.position.set(-250,100,220);
 // light8.position.set(0,160,0);
  scene.add(light_special1);





   light_special2 = new THREE.PointLight(color7, 25, 180, decay);
  light_special2.position.set(0,130,200);
 // light8.position.set(0,160,0);
 // scene.add(light_special2);




 //var geometry = new THREE.BoxGeometry( 20, 30, 20 );
 // var material = new THREE.MeshPhongMaterial( {color: color7, shininess: 40,reflectivity: 6} );
  cube_special3 = new THREE.Mesh( geometry, material );
  cube_special3.position.set(-250,200,420);
 // scene.add( cube_special3 );


   light_special3 = new THREE.PointLight(color7, 50, 150, decay);
  light_special3.position.set(250,100,220);
 // light8.position.set(0,160,0);
  scene.add(light_special3)
 /* light_special1 = new THREE.SpotLight(color7, 2, 200, 1.8,0,1);
  light_special1.position.set(-250,130,200);
 // light8.position.set(0,160,0);
  scene.add(light_special1);

   light_special2 = new THREE.SpotLight(color7, 2, 200, 1.8,0,1);
  light_special2.position.set(0,130,200);
 // light8.position.set(0,160,0);
  scene.add(light_special2);

   light_special3 = new THREE.SpotLight(color7, 2, 200, 1.8,0,1);
  light_special3.position.set(250,130,200);
 // light8.position.set(0,160,0);
  scene.add(light_special3);*/

   /*light_special4 = new THREE.PointLight(color7, intensity, distance, decay);
  light_special4.position.set(10,130,160);
 // light8.position.set(0,160,0);
  scene.add(light_special4);*/

  // spotlight #1 -- orange color left side
  /*spotlight1 = new THREE.PointLight(0xff9933);
  spotlight1.position.set(740,100,740);
  spotlight1.intensity = 1.7;
  spotlight1.distance = 600;
  spotlight1.angle = 1.05;
  spotlight1.pneumba = 0;
  // must enable shadow casting ability for the light
  scene.add(spotlight1);

  // spotlight #2 -- orange color right side
  spotlight2 = new THREE.PointLight(0xff9933);
  spotlight2.position.set(-740,100,740);
  spotlight2.intensity = 1.7;
  spotlight2.distance = 600;
  spotlight2.angle = 1.05;
  spotlight2.pneumba = 0;
  // must enable shadow casting ability for the light
  scene.add(spotlight2);*/


  /* // spotlight #3 -- orange color right-back side
  var spotlight3 = new THREE.SpotLight(0xff9933);
  spotlight3.position.set(-740,100,-740);
  spotlight3.shadowCameraVisible = true;
  spotlight3.shadowDarkness = 0.95;
  spotlight3.intensity = 1.7;
  spotlight3.distance = 600;
  spotlight3.angle = 1.05;
  spotlight3.pneumba = 0;
  // must enable shadow casting ability for the light
  spotlight3.castShadow = true;
  scene.add(spotlight3);*/


  //add orbital controls
  controls = new THREE.OrbitControls(camera);
  controls.enabled = false;
  controls.update();

  // add audio DJ MERCUS

  var listener = new THREE.AudioListener();

    var audio = new THREE.Audio( listener );

    var mediaElement = new Audio( 'MERCUS.mp3' );
    mediaElement.loop = true;
    mediaElement.play();

    audio.setMediaElementSource( mediaElement );


     
  


}

 /* function initMp3Player()
    {
        context = new webkitAudioContext(); // AudioContext object instance
        analyser = context.createAnalyser(); // AnalyserNode method
        // Re-route audio playback into the processing graph of the AudioContext
        source = context.createMediaElementSource(audio); 
        source.connect(analyser);
        analyser.connect(context.destination);
        frameLooper();
      }

function frameLooper()
{
  window.webkitRequestAnimationFrame(frameLooper);
  fbc_array = new Uint8Array(analyser.frequencyBinCount);
  analyser.getByteFrequencyData(fbc_array);
  for (var i = 0; i < bars; i++)
   {
    /*bar_x = i * 3;
    bar_width = 2;
    bar_height = -(fbc_array[i] / 2);
    //  fillRect( x, y, width, height ) // Explanation of the parameters below
    ctx.fillRect(bar_x, canvas.height, bar_width, bar_height);
    light8.position.y = Math.sin(fbc_array[i] / 2);
    console.log(fbc_array[i]);
  }
}*/


function draw()
{
  //draw disco ball
  var geo = new THREE.SphereGeometry(55, 30, 20);
  var mat = new THREE.MeshPhongMaterial({
    emissive: '#222',
    shininess: 15,
    reflectivity: 6.5,
    shading: THREE.FlatShading,
    specular: 'white',
    color: 'gray',
    side: THREE.DoubleSide,
    envMap: cubeCamera.renderTarget.texture,
    combine: THREE.AddOperation
  });
  sphere = new THREE.Mesh(geo, mat);
  sphere.position.y = 200;
  scene.add(sphere);

  //wall
  var geometry = new THREE.BoxGeometry( 1500, 500, 5 );
  var material = new THREE.MeshPhongMaterial( {color: 0x000000, shininess: 40,reflectivity: 6 } );
   var cube = new THREE.Mesh( geometry, material );
  cube.position.y = 80;
  cube.position.x = 0;
   cube.position.z = 450;
  scene.add( cube );

  //wall2
  var geometry = new THREE.BoxGeometry( 5, 500, 1500 );
  var material = new THREE.MeshPhongMaterial( {color: 0x000000} );
   var cube = new THREE.Mesh( geometry, material );
  cube.position.y = 80;
  cube.position.x = 450;
   cube.position.z = 450;
  scene.add( cube );

    //wall3
  var geometry = new THREE.BoxGeometry( 5, 500, 1500 );
  var material = new THREE.MeshPhongMaterial( {color: 0x000000} );
   var cube = new THREE.Mesh( geometry, material );
  cube.position.y = 80;
  cube.position.x = -450;
   cube.position.z = 450;
  scene.add( cube );

 //wall4  //text
  var geometry = new THREE.BoxGeometry( 400, 100, 8 );
  var material = new THREE.MeshPhongMaterial( {color: 0xffffff, shininess: 40,reflectivity: 6 } );
   var cube = new THREE.Mesh( geometry, material );
  cube.position.y = 200;
  cube.position.x = 0;
   cube.position.z = 450;
  scene.add( cube );

     //konsola
  var geometry = new THREE.BoxGeometry( 200, 20, 50 );
  var material = new THREE.MeshPhongMaterial( {color: 0xffffff} );
   var cube = new THREE.Mesh( geometry, material );
  cube.position.y = 60;
  cube.position.x = 0;
   cube.position.z = 80;
  scene.add( cube );
  // konsola noga1
    var geometry = new THREE.BoxGeometry( 20, 50, 50 );
  var material = new THREE.MeshPhongMaterial( {color: 0xffffff} );
   var cube = new THREE.Mesh( geometry, material );
  cube.position.y = 30;
  cube.position.x = 90;
   cube.position.z = 80;
  scene.add( cube );
    // konsola noga2
    var geometry = new THREE.BoxGeometry( 20, 50, 50 );
  var material = new THREE.MeshPhongMaterial( {color: 0xffffff} );
   var cube = new THREE.Mesh( geometry, material );
  cube.position.y = 30;
  cube.position.x = -90;
   cube.position.z = 80;
  scene.add( cube )

  //deck1
  
    var geometry = new THREE.CylinderGeometry( 20, 20, 3, 30 );
    
  var material = new THREE.MeshPhongMaterial( {color: 0x000000} );
  var cylinder = new THREE.Mesh( geometry, material );
  scene.add( cylinder )
  cylinder.position.y = 50;
  cylinder.position.x = 50;
  cylinder.position.y = 80;
//deck 2
  var geometry = new THREE.CylinderGeometry( 20, 20, 3, 30 );
  
var material = new THREE.MeshPhongMaterial( {color: 0x000000} );
var cylinder = new THREE.Mesh( geometry, material );
scene.add( cylinder )
cylinder.position.y = 50;
cylinder.position.x = -50;
cylinder.position.y = 80;
}
//mikser
 var geometry = new THREE.BoxGeometry( 40, 10, 40 );
  var material = new THREE.MeshPhongMaterial( {color: 0xf0ff00} );
   var cube = new THREE.Mesh( geometry, material );
  cube.position.y = 70;
  cube.position.x = 0;
   cube.position.z = 80;
  scene.add( cube );

//potencjometr
  var geometry = new THREE.CylinderGeometry( 3, 3, 3, 3 );
  
var material = new THREE.MeshPhongMaterial( {color: 0xffffff} );
var cylinder = new THREE.Mesh( geometry, material );
cylinder.position.y = 100;
cylinder.position.x = -5;
cylinder.position.y = 85;
scene.add( cylinder )


//potencjometr2
  var geometry = new THREE.CylinderGeometry( 3, 3, 3, 3 );
  
var material = new THREE.MeshPhongMaterial( {color: 0xffffff} );
var cylinder = new THREE.Mesh( geometry, material );
cylinder.position.y = 100;
cylinder.position.x = 5;
cylinder.position.y = 85;
scene.add( cylinder )





function create_lights()
{
  var pointlight = new THREE.PointLight( 0xff0000 );
  //pointlight.position.set( 0, 5, 0 );

 //spotLight.castShadow = true;

 // pointlight.shadow.mapSize.width = 1024;
  //pointlight.shadow.mapSize.height = 1024;

 // pointlight.shadow.camera.near = 500;
  //pointlight.shadow.camera.far = 4000;
  //pointlight.shadow.camera.fov = 30;

  //scene.add( pointlight );
  // spotlight #2 -- red, light shadow
  // spotlight #3
 // spotlight #1 -- yellow, dark shadow
 /* spotlight = new THREE.SpotLight(0xffff00);
  spotlight.position.set(0,150,0);
  spotlight.shadowCameraVisible = true;
  spotlight.shadowDarkness = 0.95;
  spotlight.intensity = 2;
  spotlight.distance = 200;
  spotlight.angle = 1.05;
  spotlight.pneumba = 1;
  // must enable shadow casting ability for the light
  spotlight.castShadow = true;
  spotlight.target.position.set(0,0,0);
  spotlight.target.updateMatrixWorld();
  scene.add( spotlight.target );
  scene.add(spotlight);*/
   
 // spotLight.target = targetObject;
  // change the direction this spotlight is facing
  /*var lightTarget = new THREE.Object3D();
  lightTarget.position.set(0,0,0);
  scene.add(lightTarget);
  spotlight3.target = lightTarget;*/
}

function draw_skybox()
{
  
  let geometry = new THREE.CubeGeometry(3000,3000,3000);

  let pics = [
    new THREE.MeshBasicMaterial({map : new THREE.TextureLoader().load('lmcity_ft.jpg'), side:THREE.DoubleSide }),
    new THREE.MeshBasicMaterial({map : new THREE.TextureLoader().load('lmcity_bk.jpg'), side:THREE.DoubleSide }),
    new THREE.MeshBasicMaterial({map : new THREE.TextureLoader().load('lmcity_up.jpg'), side:THREE.DoubleSide }),
    new THREE.MeshBasicMaterial({map : new THREE.TextureLoader().load('lmcity_dn.jpg'), side:THREE.DoubleSide }),
    new THREE.MeshBasicMaterial({map : new THREE.TextureLoader().load('lmcity_rt.jpg'), side:THREE.DoubleSide }),
    new THREE.MeshBasicMaterial({map : new THREE.TextureLoader().load('lmcity_lf.jpg'), side:THREE.DoubleSide })
  ];


  let material = new THREE.MeshFaceMaterial( pics );
  let skybox = new THREE.Mesh(geometry, material);
  scene.add(skybox); 
}
/*
function update(var t, var d)
{
  spotlight = new THREE.SpotLight(0xffff00);
  spotlight.position.set(0,150,0);
  spotlight.shadowCameraVisible = true;
  spotlight.shadowDarkness = 0.95;
  spotlight.intensity = 2;
  spotlight.distance = 200;
  spotlight.angle = 1.05;
  spotlight.pneumba = 1;
  // must enable shadow casting ability for the light
  spotlight.castShadow = true;
  scene.add(spotlight);
  targetObject = new THREE.Object3D();
  targetObject.set.position(0,0,0);
  scene.add(targetObject);
  spotLight.target = targetObject;
}
*/


// Create a new instance of an audio object and adjust some of its properties

// frameLooper() animates any style of graphics you wish to the audio frequency
// Looping at the default frame rate that the browser provides(approx. 60 FPS)
/*function frameLooper()
{
  window.webkitRequestAnimationFrame(frameLooper);
  fbc_array = new Uint8Array(analyser.frequencyBinCount);
  analyser.getByteFrequencyData(fbc_array);
  ctx.clearRect(0, 0, canvas.width, canvas.height); // Clear the canvas
  ctx.fillStyle = '#00CCFF'; // Color of the bars
  bars = 100;
  for (var i = 0; i < bars; i++) {
    bar_x = i * 3;
    bar_width = 2;
    bar_height = -(fbc_array[i] / 2);
    //  fillRect( x, y, width, height ) // Explanation of the parameters below
    ctx.fillRect(bar_x, canvas.height, bar_width, bar_height);
  }
}*/

animate();

function animate()
{
  //animation
  requestAnimationFrame(animate);
  sphere.rotation.y += 0.0045;

  //move color lights
  var time = Date.now() * 0.0025;
  var d = 100;
 
   light2.position.x = Math.cos(time *0.5) * d * 4;
 // light2.position.y = Math.cos(time * 0.1) * d;
  light2.position.z = Math.sin(time *0.5) * d * 4;

   light3.position.x = Math.cos(time *0.3) * d * 3;
 // light3.position.y = Math.cos(time * 0.1) * d;
  light3.position.z = Math.sin(time *0.5) * d * 3;

  light4.position.x = Math.cos(time *0.2) * d * 2;
 // light4.position.y = Math.cos(time * 0.1) * d;
  light4.position.z = Math.sin(time *0.5) * d * 2;

  light5.position.x = Math.cos(time *0.1) * d * 1;
 // light5.position.y = Math.cos(time * 0.1) * d;
  light5.position.z = Math.sin(time *0.5) * d * 1;

  light6.position.x = Math.sin(time * 0.5) * d*3.5;
  //light6.position.y = Math.sin(time * 0.3) * d;
  light6.position.z = Math.cos(time * 0.5) * d*3.5;
  
 light7.position.x = Math.sin(time * 0.4) * d*2.7;
//  light7.position.y = Math.sin(time * 0.1) * d;
  light7.position.z = Math.cos(time * 0.5) * d*2.7;
  //light8.position.y = Math.sin(time * 0.5);
/*
  SPECIAL 3 lights
*/
  light_special1.position.x = Math.sin(time *0.5) * d*-5;
 

  light_special2.position.x = Math.sin(time *0.5) * d;


  light_special3.position.x = Math.sin(time *0.5) * d*5;
   //cube_special3.rotation.y = Math.sin(time *0.5);
  //cube_special3.rotation.z = Math.sin(time *0.5);




  light_special1.position.z = Math.cos(time *0.2) * d*0.5;
 // light_special2.position.z = Math.sin(time *0.5) * d;
  light_special3.position.z = Math.cos(time *0.2) * d*0.5;
//////////////////////////////////////////////////////////////
 // spotlight1.position.y = Math.sin(time * 4) * d;
  //spotlight2.position.y = Math.sin(time * 4) * d;
  //Update the render target cube
  sphere.visible = false;
  cubeCamera.position.copy(sphere.position);
  cubeCamera.update(renderer, scene);

  //renderer
  sphere.visible = true;
  stats.update();
  controls.update();
  renderer.render(scene, camera);
}


function onDocumentKeyDown(event) {
            let key = event.which;

            if (key == 'w'.charCodeAt(0) || key == 'W'.charCodeAt(0))   //turn off the white light
            {
                light8.visible = false;
            }
            else if (key == 'b'.charCodeAt(0) || key == 'B'.charCodeAt(0))  //turn off the blue light
            {
                light2.visible = false;
            }
            else if (key == 'r'.charCodeAt(0) || key == 'R'.charCodeAt(0))  //turn off the red light
            {
                light3.visible = false;
            }
             else if (key == 'y'.charCodeAt(0) || key == 'Y'.charCodeAt(0))  //turn off the yellow light
            {
                light6.visible = false;
            }
            else if (key == 'x'.charCodeAt(0) || key == 'X'.charCodeAt(0))  //turn off extra lights as on the scene
            {
               //do to something
                light_special1.visible = false;
                light_special2.visible = false;
                light_special3.visible = false;
                //light_special4.visible = false;
            }
            else if (key == 'a'.charCodeAt(0) || key == 'A'.charCodeAt(0))  //turn on the all lights
            {
                light8.visible = true;
                light2.visible = true;
                light3.visible = true;
                light6.visible = true;
            }
            else if (key == 'z'.charCodeAt(0) || key == 'Z'.charCodeAt(0))  //turn on the extra lights
            {
                light_special1.visible = true;
                light_special2.visible = true;
                light_special3.visible = true;
                //light_special4.visible = true;
            }
        };

</script>

</body>
</html>


