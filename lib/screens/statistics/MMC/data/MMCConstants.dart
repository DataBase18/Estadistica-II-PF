
class MMCConstants{
  static  String instructions=""
      "Antes de cargar el archivo Excel, asegúrate de que los datos estén limpios "
      "y formateados correctamente. Elimina cualquier fila intermedia vacía para"
      " evitar posibles errores de carga. Verifica que todos los valores estén en"
      " formato numérico. Además, es importante tener en cuenta que la primera"
      " columna del archivo Excel debe contener la variable independiente, mientras"
      " que la segunda columna debe contener la variable dependiente.";
  static String selectedFileTextButton="Seleccionar archivo";
  static String firstRowTitlesCheckLabel= "Primera fila de encabezados";
  static String readExcelError="Ocurrio un error al leer el excel";

  static String emptyXValueMessage="Se encontro un valor vacio en la variable X de la fila ";
  static String emptyYValueMessage="Se encontro un valor vacio en la variable Y de la fila ";
  static String noNumberXValueMessage="Se ingreso un valor no numerico en la variable X de la fila ";
  static String noNumberYValueMessage="Se ingreso un valor no numerico en la variable Y de la fila ";
  static String projectedValueLabel="Valor a proyectar";
  static String invalidProjectValueMessage="El valor a pronosticar no es válido";
  static String processMMCTextButton="Proyectar";
  static String equationResultText="Ecuación de la recta: ";
  static String yResultText="Proyección: ";
  static String bResultText="Valor de b: ";
  static String aResultText="Valor de a: ";
  static String cResultText="Valor de c: ";
  static String eSResultText="Error Standar de Estimación: ";
  static String fileToProcess="Archivo a procesar";
  static String typeCorrelationText ="Tipo de correlación: ";
  static String historyType ="Proyección de datos - MMC";
}