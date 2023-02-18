use proc_macro::TokenStream;
use quote::quote;
use syn;

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
    let gen = quote! {
        impl Resource for #name {
            fn get_href(&self) -> String {
                String::from("Derive works!")
            }
        }
    };
    gen.into()
}
