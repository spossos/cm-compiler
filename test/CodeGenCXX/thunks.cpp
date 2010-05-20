// RUN: %clang_cc1 %s -triple=x86_64-apple-darwin10 -emit-llvm -o - | FileCheck %s

namespace Test1 {

// Check that we emit a non-virtual thunk for C::f.

struct A {
  virtual void f();
};

struct B {
  virtual void f();
};

struct C : A, B {
  virtual void c();
  
  virtual void f();
};

// CHECK: define void @_ZThn8_N5Test11C1fEv(
void C::f() { }

}

namespace Test2 {

// Check that we emit a thunk for B::f since it's overriding a virtual base.

struct A {
  virtual void f();
};

struct B : virtual A {
  virtual void b();
  virtual void f();
};

// CHECK: define void @_ZTv0_n24_N5Test21B1fEv(
void B::f() { }

}

namespace Test3 {

// Check that we emit a covariant thunk for B::f.

struct V1 { };
struct V2 : virtual V1 { };

struct A {
  virtual V1 *f();
};

struct B : A {
  virtual void b();
  
  virtual V2 *f();
};

// CHECK: define %{{.*}}* @_ZTch0_v0_n24_N5Test31B1fEv(
V2 *B::f() { return 0; }

}

namespace Test4 {

// Check that the thunk for 'C::f' has the same visibility as the function itself.

struct A {
  virtual void f();
};

struct B {
  virtual void f();
};

struct __attribute__((visibility("protected"))) C : A, B {
  virtual void c();
  
  virtual void f();
};

// CHECK: define protected void @_ZThn8_N5Test41C1fEv(
void C::f() { }

}

// Check that the thunk gets internal linkage.
namespace {

struct A {
  virtual void f();
};

struct B {
  virtual void f();
};

struct C : A, B {
  virtual void c();

  virtual void f();
};

void C::f() { }

}

// Force C::f to be used.
void f() { 
  C c; 
  
  c.f();
}

namespace Test5 {

// Check that the thunk for 'B::f' gets the same linkage as the function itself.
struct A {
  virtual void f();
};

struct B : virtual A {
  virtual void f() { }
};

void f(B b) {
  b.f();
}
}

namespace Test6 {
  struct X {
    X();
    X(const X&);
    X &operator=(const X&);
    ~X();
  };

  struct P {
    P();
    P(const P&);
    ~P();
    X first;
    X second;
  };

  P getP();

  struct Base1 {
    int i;

    virtual X f() { return X(); }
  };

  struct Base2 {
    float real;

    virtual X f() { return X(); }
  };

  struct Thunks : Base1, Base2 {
    long l;

    virtual X f();
  };

  // CHECK: define void @_ZThn16_N5Test66Thunks1fEv
  // CHECK-NOT: memcpy
  // CHECK: {{call void @_ZN5Test66Thunks1fEv.*sret}}
  // CHECK: ret void
  X Thunks::f() { return X(); }
}

// This is from Test5:
// CHECK: define linkonce_odr void @_ZTv0_n24_N5Test51B1fEv
// CHECK: define internal void @_ZThn8_N12_GLOBAL__N_11C1fEv(
