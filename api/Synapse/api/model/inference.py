import joblib
import pandas as pd
import numpy as np
import os

# PATH ABSOLUT
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(CURRENT_DIR, "garden", "penguin_species_model.pkl")

# Load model + semua komponen
model_data = joblib.load(MODEL_PATH)
model = model_data["model"]
scaler = model_data["scaler"]
full_features = model_data["full_features"]
numeric_features = model_data["numeric_features"]

print(f"Full features: {full_features}")
print(f"Numeric features: {numeric_features}")


def predict_penguin_species(input_data: dict) -> str:
    data = input_data.copy()

    # Fix sex
    sex = str(data.get("sex")).upper().strip()
    is_male = 1.0 if sex == "MALE" else 0.0
    data["is_male"] = is_male  # langsung buat kolom is_male

    # Fix island: MANUAL one-hot (exact match full_features)
    island = str(data.get("island", "")).capitalize()
    data["island_Biscoe"] = 1.0 if island == "Biscoe" else 0.0
    data["island_Dream"] = 1.0 if island == "Dream" else 0.0
    data["island_Torgersen"] = 1.0 if island == "Torgersen" else 0.0

    # Ke DataFrame
    df = pd.DataFrame([data])

    # Scale numeric → buat kolom _scaled (persis training)
    scaled_values = scaler.transform(df[numeric_features])
    for i, col in enumerate(numeric_features):
        df[f"{col}_scaled"] = scaled_values[:, i]

    # Hapus kolom numeric asli (karena model pakai _scaled)
    df = df.drop(columns=numeric_features, errors="ignore")

    # Tambah kolom hilang lain jika ada (safety)
    for col in full_features:
        if col not in df.columns:
            df[col] = 0.0

    # Urutkan EXACT sesuai full_features
    df = df.reindex(columns=full_features, fill_value=0.0)

    # Prediksi
    pred = model.predict(df)[0]
    species_map = {0: "Adelie", 1: "Chinstrap", 2: "Gentoo"}
    result = species_map.get(int(pred), "Unknown")

    return result
