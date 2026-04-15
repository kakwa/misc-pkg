// Simplified build.rs for librespot-core that doesn't use vergen
// This avoids the vergen_lib version conflict issue

use rand::Rng;
use rand_distr::Alphanumeric;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Set dummy build metadata
    println!("cargo:rustc-env=VERGEN_GIT_SHA=unknown");
    println!("cargo:rustc-env=VERGEN_GIT_COMMIT_DATE=unknown");
    println!("cargo:rustc-env=VERGEN_BUILD_DATE=unknown");
    
    let build_id = match std::env::var("SOURCE_DATE_EPOCH") {
        Ok(val) => val,
        Err(_) => rand::rng()
            .sample_iter(Alphanumeric)
            .take(8)
            .map(char::from)
            .collect(),
    };

    println!("cargo:rustc-env=LIBRESPOT_BUILD_ID={build_id}");
    Ok(())
}
