#include <nan.h>

using v8::FunctionTemplate;
using v8::Handle;
using v8::Object;
using v8::String;
using Nan::GetFunction;
using Nan::New;
using Nan::Set;

NAN_METHOD(Method) {
  info.GetReturnValue().Set(New<String>("Power").ToLocalChecked());
}

NAN_MODULE_INIT(InitAll) {
  Set(target, New<String>("Method").ToLocalChecked(),
    GetFunction(New<FunctionTemplate>(Method)).ToLocalChecked());
}

NODE_MODULE(power, InitAll)