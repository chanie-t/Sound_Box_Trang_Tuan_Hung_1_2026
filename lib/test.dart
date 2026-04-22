// 
class MusicName {
  String tenbaihat = "";
  String tencasi = "";

  MusicName(String tenbaihat, String tencasi) {
    this.tenbaihat = tenbaihat;
    this.tencasi = tencasi;
  }

  void showInfo() {
    print("Tên bài hát: $tenbaihat");
    print("Tên ca sĩ: $tencasi");
  }
}



//interface 
//Interface
abstract class  IsLove{
  void love();  
}

//Class implement for Interface (abstract class)
class LovePerform implements IsLove{
  @override
  void love(){
    print("I Love you");
  }
}
  @override


//generic 
class GenericsClass<T> {
  var obj;

  set object(T obj) {
    this.obj = obj;
  }

  get object {
    return obj;
  }
}

void main() {
  var stringObject = GenericsClass<String>();
  stringObject.obj = "hallo";
  print(stringObject.obj);

  var intObject = GenericsClass<int>();
  intObject.obj = 1000;
  print(intObject.obj);

  var objObject = GenericsClass<Set<Object>>();
  objObject.obj = {"nguyen", 20}; // This creates a Set<Object>
  print(objObject.obj);

  var listObject = GenericsClass<List<Set<Object>>>();
  listObject.obj = [
    {'van', 30}, // This creates a Set<Object>
    {'tran', 10}, // This creates a Set<Object>
  ];
  for (var item in listObject.obj) {
    print(item);
  }
   LovePerform lovePer = new LovePerform();
  lovePer.love();
  var m = MusicName("Nơi này có anh", "Sơn Tùng");
  m.showInfo();
}