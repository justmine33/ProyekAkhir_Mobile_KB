import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .model.inference import predict_penguin_species


@csrf_exempt
def predict(request):
    if request.method == "POST":
        try:
            # Debug: lihat apa yang dikirim Flutter
            print("Raw body:", request.body.decode())

            payload = json.loads(request.body)
            input_data = payload.get("data", {})

            # LANGSUNG pakai key yang dikirim Flutter (culmen_*)
            mapped_data = {
                "culmen_length_mm": float(input_data.get("culmen_length_mm", 0)),
                "culmen_depth_mm": float(input_data.get("culmen_depth_mm", 0)),
                "flipper_length_mm": float(input_data.get("flipper_length_mm", 0)),
                "body_mass_g": float(input_data.get("body_mass_g", 0)),
                "sex": str(input_data.get("sex", "")).upper(),
            }

            print("Mapped data:", mapped_data)  # debug

            species = predict_penguin_species(mapped_data)

            species_map = {"Adelie": 0, "Chinstrap": 1, "Gentoo": 2}
            class_id = species_map.get(species, -1)

            return JsonResponse({
                "species": species,
                "prediction": [class_id]
            }, status=200)

        except json.JSONDecodeError as e:
            return JsonResponse({"error": "Invalid JSON"}, status=400)
        except Exception as e:
            print("Error:", str(e))  # muncul di terminal Django
            return JsonResponse({"error": str(e)}, status=400)

    else:
        return JsonResponse({"info": "POST to /api/predict"}, status=200)