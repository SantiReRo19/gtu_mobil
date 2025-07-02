import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:gtu_mobile/config/routes/app_router.dart';

const _googleAPIKey = 'API-KEY'; // Replace with your actual Google API key

class SearchRoute extends StatelessWidget {
  const SearchRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: GooglePlacesAutoCompleteTextFormField(
            googleAPIKey: _googleAPIKey,
            decoration: const InputDecoration(
              hintText: '¿A dónde quieres ir?',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              border: InputBorder.none,
            ),
            countries: ['co'],
            languageCode: 'es',

            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa un texto';
              }
              return null;
            },
            // proxyURL: _yourProxyURL,
            maxLines: 1,
            overlayContainerBuilder: (child) => Material(
              elevation: 1.0,
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              child: child,
            ),
            fetchCoordinates: true,
            onPlaceDetailsWithCoordinatesReceived: (prediction) {
              final latStr = prediction.lat?.toString() ?? '0.0';
              final lngStr = prediction.lng?.toString() ?? '0.0';
              final lat = double.tryParse(latStr) ?? 0.0;
              final lng = double.tryParse(lngStr) ?? 0.0;
              if (lat == 0.0 || lng == 0.0) return;
              context.pushNamed(AppRouterName.nearbyRoutes, extra: [lat, lng]);
            },
            onSuggestionClicked: (prediction) {},

            minInputLength: 3,
          ),
          /*
          child: TextFormField(
            readOnly: true,
            onTap: () {},
            decoration: InputDecoration(
              hintText: '¿A dónde quieres ir?',

              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
            ),
          ), */
        ),
      ),
    );
  }
}
