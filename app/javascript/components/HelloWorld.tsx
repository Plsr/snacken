import * as React from 'react'

class HelloWorld extends React.Component<Props> {
  render(): React.ReactNode {
    return <React.Fragment>Greeting: {this.props.greeting}</React.Fragment>
  }
}

interface Props {
  greeting: string
}

export default HelloWorld
