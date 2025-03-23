import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final LinearGradient? gradient;
  final double borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry padding;
  final bool useShadow;
  final VoidCallback? onTap;
  
  const GradientContainer({
    Key? key,
    required this.child,
    this.gradient,
    this.borderRadius = 16.0,
    this.height,
    this.width,
    this.padding = const EdgeInsets.all(16.0),
    this.useShadow = true,
    this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final container = Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient ?? AppConstants.primaryGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: useShadow 
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: child,
    );
    
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: container,
      );
    }
    
    return container;
  }
}

class AnimatedGradientContainer extends StatefulWidget {
  final Widget child;
  final LinearGradient? gradient;
  final double borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry padding;
  final bool useShadow;
  final VoidCallback? onTap;
  final Duration duration;
  final bool animate;
  
  const AnimatedGradientContainer({
    Key? key,
    required this.child,
    this.gradient,
    this.borderRadius = 16.0,
    this.height,
    this.width,
    this.padding = const EdgeInsets.all(16.0),
    this.useShadow = true,
    this.onTap,
    this.duration = const Duration(milliseconds: 300),
    this.animate = true,
  }) : super(key: key);
  
  @override
  State<AnimatedGradientContainer> createState() => _AnimatedGradientContainerState();
}

class _AnimatedGradientContainerState extends State<AnimatedGradientContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    if (widget.animate) {
      _controller.forward();
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _controller,
        child: GradientContainer(
          child: widget.child,
          gradient: widget.gradient,
          borderRadius: widget.borderRadius,
          height: widget.height,
          width: widget.width,
          padding: widget.padding,
          useShadow: widget.useShadow,
          onTap: widget.onTap,
        ),
      ),
    );
  }
} 