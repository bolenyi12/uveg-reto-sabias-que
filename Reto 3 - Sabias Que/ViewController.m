//
//  ViewController.m
//  Reto 3 - Sabias Que
//
//  Created by Forte Apps on 19/07/20.
//  Copyright © 2020 UVEG. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

// Controles principales
@property (nonatomic, strong) UILabel *tituloLabel;
@property (nonatomic, strong) UILabel *instruccionLabel;

@property (nonatomic, strong) UIButton *cienciaButton;
@property (nonatomic, strong) UIButton *historiaButton;
@property (nonatomic, strong) UIButton *tecnologiaButton;
@property (nonatomic, strong) UIButton *mostrarButton;

// Contenedor de datos
@property (nonatomic, strong) UIView *ventanaDatos;
@property (nonatomic, strong) UILabel *mensajeInicial;
@property (nonatomic, strong) UILabel *datoTitulo;
@property (nonatomic, strong) UILabel *datoTexto;

// Imágenes
@property (nonatomic, strong) UIImageView *imagen1;
@property (nonatomic, strong) UIImageView *imagen2;
@property (nonatomic, strong) UIImageView *imagen3;

// Datos y selección
@property (nonatomic, strong) NSString *categoriaSeleccionada;
@property (nonatomic, strong) NSDictionary *baseDeDatos;
@property (nonatomic, strong) NSMutableDictionary *indices;

@end

@implementation ViewController

#pragma mark - Inicialización

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.93
                                                green:0.94
                                                 blue:0.96
                                                alpha:1.0];

    self.categoriaSeleccionada = @"tecnologia";

    [self crearBaseDeDatos];
    [self configurarIndices];
    [self crearInterfaz];
}

#pragma mark - Base de datos

- (void)crearBaseDeDatos {

    self.baseDeDatos = @{

        @"tecnologia": @[
            @{
                @"titulo": @"¿Sabías que... el primer mouse de computadora estaba hecho de madera?",
                @"texto": @"En 1964, el ingeniero Douglas Engelbart desarrolló uno de los primeros prototipos de ratón para computadora. Su carcasa era de madera, tenía forma rectangular y utilizaba dos ruedas metálicas para detectar el movimiento."
            },
            @{
                @"titulo": @"¿Sabías que... el primer mensaje enviado por internet fue simplemente 'LO'?",
                @"texto": @"El 29 de octubre de 1969, investigadores de UCLA intentaron enviar la palabra LOGIN a una computadora en Stanford mediante ARPANET. El sistema colapsó después de transmitir las dos primeras letras."
            },
            @{
                @"titulo": @"¿Sabías que... la primera cámara digital tardó 23 segundos en guardar una foto?",
                @"texto": @"Inventada en 1975 por Steven Sasson en Kodak, pesaba casi 4 kilogramos, tenía una resolución de apenas 0.01 megapíxeles y almacenaba fotografías en blanco y negro en una cinta de casete."
            }
        ],

        @"ciencia": @[
            @{
                @"titulo": @"¿Sabías que... las abejas pueden reconocer rostros humanos?",
                @"texto": @"A pesar de tener un cerebro diminuto, las abejas pueden aprender a distinguir patrones visuales y reconocer configuraciones de rasgos faciales."
            },
            @{
                @"titulo": @"¿Sabías que... un día en Venus es más largo que un año venusiano?",
                @"texto": @"Venus tarda aproximadamente 243 días terrestres en completar una rotación sobre su eje, pero solo necesita 225 días para dar una vuelta alrededor del Sol."
            },
            @{
                @"titulo": @"¿Sabías que... el agua caliente puede congelarse más rápido que el agua fría?",
                @"texto": @"Este fenómeno se conoce como efecto Mpemba. Bajo determinadas condiciones, el agua inicialmente caliente puede congelarse antes que una cantidad equivalente de agua fría."
            }
        ],

        @"historia": @[
            @{
                @"titulo": @"¿Sabías que... Oxford es más antigua que el Imperio Azteca?",
                @"texto": @"La enseñanza en Oxford comenzó alrededor del año 1096, mientras que la fundación de México-Tenochtitlan ocurrió aproximadamente en 1325."
            },
            @{
                @"titulo": @"¿Sabías que... Cleopatra vivió más cerca de la llegada a la Luna que de las pirámides?",
                @"texto": @"La Gran Pirámide de Guiza fue construida hacia el 2560 a. C. Cleopatra VII reinó hasta el 30 a. C., mientras que el Apolo 11 llegó a la Luna en 1969."
            },
            @{
                @"titulo": @"¿Sabías que... la guerra más corta de la historia duró apenas 38 minutos?",
                @"texto": @"El 27 de agosto de 1896 tuvo lugar la Guerra Anglo-Zanzibariana. Tras un breve bombardeo británico, se declaró el alto el fuego en menos de 40 minutos."
            }
        ]
    };
}

- (void)configurarIndices {

    self.indices = [@{
        @"ciencia": @0,
        @"historia": @0,
        @"tecnologia": @0
    } mutableCopy];
}

#pragma mark - Crear interfaz

- (void)crearInterfaz {

    // Scroll para adaptarse a diferentes tamaños de iPhone

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:scrollView];

    [NSLayoutConstraint activateConstraints:@[
        [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];

    UIView *contenido = [[UIView alloc] init];
    contenido.translatesAutoresizingMaskIntoConstraints = NO;

    [scrollView addSubview:contenido];

    [NSLayoutConstraint activateConstraints:@[
        [contenido.topAnchor constraintEqualToAnchor:scrollView.contentLayoutGuide.topAnchor],
        [contenido.bottomAnchor constraintEqualToAnchor:scrollView.contentLayoutGuide.bottomAnchor],
        [contenido.leadingAnchor constraintEqualToAnchor:scrollView.contentLayoutGuide.leadingAnchor],
        [contenido.trailingAnchor constraintEqualToAnchor:scrollView.contentLayoutGuide.trailingAnchor],
        [contenido.widthAnchor constraintEqualToAnchor:scrollView.frameLayoutGuide.widthAnchor]
    ]];

    // Título principal

    self.tituloLabel = [[UILabel alloc] init];
    self.tituloLabel.text = @"¿Sabías qué?";
    self.tituloLabel.font = [UIFont systemFontOfSize:28 weight:UIFontWeightRegular];
    self.tituloLabel.textColor = UIColor.blackColor;
    self.tituloLabel.textAlignment = NSTextAlignmentCenter;
    self.tituloLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [contenido addSubview:self.tituloLabel];

    // Instrucción

    self.instruccionLabel = [[UILabel alloc] init];
    self.instruccionLabel.text = @"Elige la categoría sobre la que deseas saber más:";
    self.instruccionLabel.font = [UIFont systemFontOfSize:15];
    self.instruccionLabel.textColor = UIColor.darkGrayColor;
    self.instruccionLabel.numberOfLines = 0;
    self.instruccionLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [contenido addSubview:self.instruccionLabel];

    // Categorías

    self.cienciaButton = [self crearBotonCategoria:@"Ciencia"];
    self.historiaButton = [self crearBotonCategoria:@"Historia"];
    self.tecnologiaButton = [self crearBotonCategoria:@"Tecnología"];

    // Botón mostrar dato

    self.mostrarButton = [UIButton buttonWithType:UIButtonTypeSystem];

    [self.mostrarButton setTitle:@"☞  Mostrar dato" forState:UIControlStateNormal];

    self.mostrarButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [self.mostrarButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];

    self.mostrarButton.backgroundColor = [UIColor colorWithRed:0.576
                                                         green:0.773
                                                          blue:0.992
                                                         alpha:1.0];

    self.mostrarButton.layer.cornerRadius = 6;
    self.mostrarButton.layer.borderWidth = 1.5;
    self.mostrarButton.layer.borderColor = UIColor.darkGrayColor.CGColor;

    self.mostrarButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.mostrarButton addTarget:self
                           action:@selector(mostrarDatoCurioso)
                 forControlEvents:UIControlEventTouchUpInside];

    [contenido addSubview:self.mostrarButton];

    [contenido addSubview:self.cienciaButton];
    [contenido addSubview:self.historiaButton];
    [contenido addSubview:self.tecnologiaButton];

    // Ventana de datos curiosos

    [self crearVentanaDatos];
    [contenido addSubview:self.ventanaDatos];

    // Distribución vertical

    [NSLayoutConstraint activateConstraints:@[

        [self.tituloLabel.topAnchor constraintEqualToAnchor:contenido.topAnchor constant:25],
        [self.tituloLabel.leadingAnchor constraintEqualToAnchor:contenido.leadingAnchor constant:25],
        [self.tituloLabel.trailingAnchor constraintEqualToAnchor:contenido.trailingAnchor constant:-25],

        [self.instruccionLabel.topAnchor constraintEqualToAnchor:self.tituloLabel.bottomAnchor constant:25],
        [self.instruccionLabel.leadingAnchor constraintEqualToAnchor:contenido.leadingAnchor constant:28],
        [self.instruccionLabel.trailingAnchor constraintEqualToAnchor:contenido.trailingAnchor constant:-28],

        [self.cienciaButton.topAnchor constraintEqualToAnchor:self.instruccionLabel.bottomAnchor constant:15],
        [self.cienciaButton.leadingAnchor constraintEqualToAnchor:contenido.leadingAnchor constant:28],

        [self.historiaButton.topAnchor constraintEqualToAnchor:self.cienciaButton.bottomAnchor constant:12],
        [self.historiaButton.leadingAnchor constraintEqualToAnchor:contenido.leadingAnchor constant:28],

        [self.tecnologiaButton.topAnchor constraintEqualToAnchor:self.historiaButton.bottomAnchor constant:12],
        [self.tecnologiaButton.leadingAnchor constraintEqualToAnchor:contenido.leadingAnchor constant:28],

        [self.mostrarButton.topAnchor constraintEqualToAnchor:self.tecnologiaButton.bottomAnchor constant:22],
        [self.mostrarButton.centerXAnchor constraintEqualToAnchor:contenido.centerXAnchor],
        [self.mostrarButton.widthAnchor constraintEqualToConstant:175],
        [self.mostrarButton.heightAnchor constraintEqualToConstant:43],

        [self.ventanaDatos.topAnchor constraintEqualToAnchor:self.mostrarButton.bottomAnchor constant:25],
        [self.ventanaDatos.leadingAnchor constraintEqualToAnchor:contenido.leadingAnchor constant:28],
        [self.ventanaDatos.trailingAnchor constraintEqualToAnchor:contenido.trailingAnchor constant:-28],
        [self.ventanaDatos.heightAnchor constraintEqualToConstant:330],

        [self.ventanaDatos.bottomAnchor constraintEqualToAnchor:contenido.bottomAnchor constant:-25]
    ]];

    // Selección inicial

    [self actualizarCategorias];
}

#pragma mark - Botones de categoría

- (UIButton *)crearBotonCategoria:(NSString *)nombre {

    UIButton *boton = [UIButton buttonWithType:UIButtonTypeSystem];

    boton.titleLabel.font = [UIFont systemFontOfSize:16];
    [boton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];

    boton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    boton.translatesAutoresizingMaskIntoConstraints = NO;

    [boton addTarget:self
              action:@selector(seleccionarCategoria:)
    forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:boton];

    [boton.heightAnchor constraintEqualToConstant:28].active = YES;
    [boton.widthAnchor constraintEqualToConstant:180].active = YES;

    [boton setTitle:nombre forState:UIControlStateNormal];

    return boton;
}

- (void)seleccionarCategoria:(UIButton *)boton {

    if (boton == self.cienciaButton) {
        self.categoriaSeleccionada = @"ciencia";
    }
    else if (boton == self.historiaButton) {
        self.categoriaSeleccionada = @"historia";
    }
    else {
        self.categoriaSeleccionada = @"tecnologia";
    }

    [self actualizarCategorias];
}

- (void)actualizarCategorias {

    [self.cienciaButton setTitle:
     [self.categoriaSeleccionada isEqualToString:@"ciencia"] ? @"◉  Ciencia" : @"◯  Ciencia"
                       forState:UIControlStateNormal];

    [self.historiaButton setTitle:
     [self.categoriaSeleccionada isEqualToString:@"historia"] ? @"◉  Historia" : @"◯  Historia"
                       forState:UIControlStateNormal];

    [self.tecnologiaButton setTitle:
     [self.categoriaSeleccionada isEqualToString:@"tecnologia"] ? @"◉  Tecnología" : @"◯  Tecnología"
                           forState:UIControlStateNormal];
}

#pragma mark - Ventana de datos

- (void)crearVentanaDatos {

    self.ventanaDatos = [[UIView alloc] init];

    self.ventanaDatos.backgroundColor = UIColor.whiteColor;
    self.ventanaDatos.layer.borderWidth = 1.5;
    self.ventanaDatos.layer.borderColor = UIColor.darkGrayColor.CGColor;
    self.ventanaDatos.layer.cornerRadius = 3;
    self.ventanaDatos.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.ventanaDatos];

    // Mensaje inicial

    self.mensajeInicial = [[UILabel alloc] init];

    self.mensajeInicial.text = @"Aquí se mostrarán los datos";
    self.mensajeInicial.font = [UIFont boldSystemFontOfSize:13];
    self.mensajeInicial.textAlignment = NSTextAlignmentCenter;
    self.mensajeInicial.textColor = UIColor.darkGrayColor;
    self.mensajeInicial.translatesAutoresizingMaskIntoConstraints = NO;

    [self.ventanaDatos addSubview:self.mensajeInicial];

    // Título del dato

    self.datoTitulo = [[UILabel alloc] init];

    self.datoTitulo.font = [UIFont boldSystemFontOfSize:13];
    self.datoTitulo.textAlignment = NSTextAlignmentCenter;
    self.datoTitulo.numberOfLines = 0;
    self.datoTitulo.translatesAutoresizingMaskIntoConstraints = NO;

    [self.ventanaDatos addSubview:self.datoTitulo];

    // Descripción

    self.datoTexto = [[UILabel alloc] init];

    self.datoTexto.font = [UIFont systemFontOfSize:12];
    self.datoTexto.textAlignment = NSTextAlignmentCenter;
    self.datoTexto.numberOfLines = 0;
    self.datoTexto.textColor = UIColor.darkGrayColor;
    self.datoTexto.translatesAutoresizingMaskIntoConstraints = NO;

    [self.ventanaDatos addSubview:self.datoTexto];

    // Imágenes del collage

    self.imagen1 = [self crearImagen];
    self.imagen2 = [self crearImagen];
    self.imagen3 = [self crearImagen];

    [self.ventanaDatos addSubview:self.imagen1];
    [self.ventanaDatos addSubview:self.imagen2];
    [self.ventanaDatos addSubview:self.imagen3];

    [NSLayoutConstraint activateConstraints:@[

        [self.mensajeInicial.centerXAnchor constraintEqualToAnchor:self.ventanaDatos.centerXAnchor],
        [self.mensajeInicial.topAnchor constraintEqualToAnchor:self.ventanaDatos.topAnchor constant:15],

        [self.datoTitulo.topAnchor constraintEqualToAnchor:self.ventanaDatos.topAnchor constant:12],
        [self.datoTitulo.leadingAnchor constraintEqualToAnchor:self.ventanaDatos.leadingAnchor constant:10],
        [self.datoTitulo.trailingAnchor constraintEqualToAnchor:self.ventanaDatos.trailingAnchor constant:-10],

        [self.datoTexto.topAnchor constraintEqualToAnchor:self.datoTitulo.bottomAnchor constant:10],
        [self.datoTexto.leadingAnchor constraintEqualToAnchor:self.ventanaDatos.leadingAnchor constant:12],
        [self.datoTexto.trailingAnchor constraintEqualToAnchor:self.ventanaDatos.trailingAnchor constant:-12],

        [self.imagen1.leadingAnchor constraintEqualToAnchor:self.ventanaDatos.leadingAnchor constant:12],
        [self.imagen1.topAnchor constraintEqualToAnchor:self.datoTexto.bottomAnchor constant:12],
        [self.imagen1.bottomAnchor constraintEqualToAnchor:self.ventanaDatos.bottomAnchor constant:-12],
        [self.imagen1.widthAnchor constraintEqualToAnchor:self.ventanaDatos.widthAnchor multiplier:0.43],

        [self.imagen2.leadingAnchor constraintEqualToAnchor:self.imagen1.trailingAnchor constant:8],
        [self.imagen2.trailingAnchor constraintEqualToAnchor:self.ventanaDatos.trailingAnchor constant:-12],
        [self.imagen2.topAnchor constraintEqualToAnchor:self.imagen1.topAnchor],
        [self.imagen2.heightAnchor constraintEqualToAnchor:self.imagen1.heightAnchor multiplier:0.48],

        [self.imagen3.leadingAnchor constraintEqualToAnchor:self.imagen2.leadingAnchor],
        [self.imagen3.trailingAnchor constraintEqualToAnchor:self.imagen2.trailingAnchor],
        [self.imagen3.topAnchor constraintEqualToAnchor:self.imagen2.bottomAnchor constant:7],
        [self.imagen3.bottomAnchor constraintEqualToAnchor:self.imagen1.bottomAnchor]
    ]];

    self.datoTitulo.hidden = YES;
    self.datoTexto.hidden = YES;

    self.imagen1.hidden = YES;
    self.imagen2.hidden = YES;
    self.imagen3.hidden = YES;
}

- (UIImageView *)crearImagen {

    UIImageView *imagen = [[UIImageView alloc] init];

    imagen.backgroundColor = [UIColor colorWithRed:0.94
                                             green:0.95
                                              blue:0.97
                                             alpha:1.0];

    imagen.contentMode = UIViewContentModeScaleAspectFill;
    imagen.clipsToBounds = YES;
    imagen.layer.borderWidth = 0.5;
    imagen.layer.borderColor = UIColor.lightGrayColor.CGColor;
    imagen.translatesAutoresizingMaskIntoConstraints = NO;

    return imagen;
}

#pragma mark - Mostrar dato curioso

- (void)mostrarDatoCurioso {

    NSArray *listaDatos = self.baseDeDatos[self.categoriaSeleccionada];

    NSInteger indice = [self.indices[self.categoriaSeleccionada] integerValue];

    NSDictionary *dato = listaDatos[indice];

    // Actualizar índice de la categoría

    NSInteger siguienteIndice = (indice + 1) % listaDatos.count;

    self.indices[self.categoriaSeleccionada] = @(siguienteIndice);

    // Actualizar contenido

    self.mensajeInicial.hidden = YES;

    self.datoTitulo.text = dato[@"titulo"];
    self.datoTexto.text = dato[@"texto"];

    self.datoTitulo.hidden = NO;
    self.datoTexto.hidden = NO;

    // Mostrar espacios de imágenes

    self.imagen1.hidden = NO;
    self.imagen2.hidden = NO;
    self.imagen3.hidden = NO;

    // Imágenes provisionales

    self.imagen1.image = [UIImage systemImageNamed:@"photo"];
    self.imagen2.image = [UIImage systemImageNamed:@"photo"];
    self.imagen3.image = [UIImage systemImageNamed:@"photo"];

    self.imagen1.tintColor = UIColor.grayColor;
    self.imagen2.tintColor = UIColor.grayColor;
    self.imagen3.tintColor = UIColor.grayColor;
}

@end
