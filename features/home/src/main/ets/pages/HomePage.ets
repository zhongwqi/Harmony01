
@Builder
export function HomePageBuilder() {
  HomePage()
}

@ComponentV2
struct HomePage {

  build() {
    Text("首页")
  }
}