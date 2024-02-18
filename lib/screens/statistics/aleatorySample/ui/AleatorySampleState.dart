
class AleatorySampleState {
    bool loading;
    int aInterval;
    int bInterval;
    List<int>? intervalPopulation;
    List<String>? valuesManuallyList;
    AleatorySampleState({
      this.loading=false,
      this.intervalPopulation,
      this.aInterval=0,
      this.bInterval=0,
      this.valuesManuallyList
    });
}