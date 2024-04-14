
class IntervalEstimationConstants {
  static String title = "Estimación por intervalos";
  static String typeCalcSample = "Experimento muestral";
  static String populationLabel = "N";
  static String sampleLabel ="n";
  static String meanLabel ="x";
  static String standardDeviationLabel = "S";
  static String sigmaLabel = "σ";
  static String iCLabel="IC";
  static String sizeSampleInputLabel  ="Tamaño de la muestra";
  static String sizePopulationInputLabel  ="Tamaño de la población";
  static String meanSampleInputLabel = "Media muestral";
  static String meanPopulationInputLabel="Media poblacional";
  static String standardDeviationInputLabel="Desviación Standard";
  static String sigmaInputLabel = "Sigma";
  static String iCInputLabel="Intervalo de confianza";
  static String calcTextButton ="Calcular";
  static String invalidValueMessage ="Valor invalido";
  static String invalidSigmaValueMessage="El valor de sigma no es valido";
  static String insufficientDataToCalcMessage = "Datos insuficientes para efectuar el calculo poblacional";
  static String notStandardDeviationWriteMessage="Debes escribir la desviación Standard";
  static String invalidPopulationValue="El valor de la población no es valido";
  static String invalidMeanValue="El valor de la media no es valido";
  static String invalidSampleValue="El valor de la muestra no es valido";
  static String invalidIcValue="El valor de confianza no es valido";
  static String resultTitle="Resultado:";
  static String explicationInfo="Explicación:";

  static String knowSigmaExplication="Se uso la formula 1.1 ya que es un experimento poblacional y se conoce sigma. La formula que se utilizó fue:  x - z*(σ/√n) <= m <=  x + z*(σ/√n)";
  static String notKnowSigmaAndKnowPopulationExplication ="Se uso la formula 1.3 debido a que la población se conoce y el porcentado de la muestra es mayor al 5%. La formula fue: x - tn-1 * (S/√n) * √(N-n / N-1) <= m <=   x + tn-1 * (S/√n) * √(N-n / N-1) ";
  static String notKnowSigmaAndPopulationExplication ="Se uso la formula 1.2 debido a que no se conoce S ni la población. La formula fue: x - tn-1 * (S/√n)  <= m <=   x + tn-1 * (S/√n) *  ";

}