use proc_macro::TokenStream;
use quote::quote;
use syn::{self, Fields::Named};

#[proc_macro_derive(Resource)]
pub fn resource_macro_derive(input: TokenStream) -> TokenStream {
    // Construct a representation of Rust code as a syntax tree
    // that we can manipulate
    let ast = syn::parse(input).unwrap();

    // Build the trait implementation
    impl_resource_macro(&ast)
}

fn impl_resource_macro(ast: &syn::DeriveInput) -> TokenStream {
    let name = &ast.ident;
    let field = &ast.data;
    if let syn::Data::Struct(struct_data) = field {
        if let Named(ref named_field) = struct_data.fields {
            for field in &named_field.named{
                let field_ident = &field.ident;
                // check if field name == "super_class"
                if !field_ident
                        .as_ref()
                        .unwrap()
                        .to_string()
                        .eq(&String::from("super_class")){
                    continue;
                }

                // Code the macro generates if "super_class" field exists
                let gen = quote! {
                    impl Resource for #name {
                        fn get_href(&self) -> String {
                            self.#field_ident.get_href()
                        }
                    }
                };
                return gen.into();
            }
            panic!("Could not find \"super_class\" field that implements the Resource trait in struct {}", name.to_string());        
        }
        // support for tuple structs goes here
        unimplemented!("Need to add support for Tuple structs here. 
        Currently, only Structs with named fields can be derived with this macro");

    } else {
        // support for enums goes here
        unimplemented!("Need to add support for Tuple structs here. 
        Currently, only Structs with named fields can be derived with this macro");
    }
}
