import { redirect } from 'next/navigation'

type Params = {
  params: { id: string }
}

export default function ProductRedirect({ params }: Params) {
  redirect(`/dashboard/products/${params.id}`)
}

